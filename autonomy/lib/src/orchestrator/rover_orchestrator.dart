import "dart:math";

import "package:autonomy/constants.dart";
import "package:autonomy/interfaces.dart";
import "dart:async";

import "package:coordinate_converter/coordinate_converter.dart";

class RoverOrchestrator extends OrchestratorInterface with ValueReporter {
  /// The GPS coordinates that the rover has traversed during the task
  final List<GpsCoordinates> traversed = [];

  /// The current path that the rover is following
  List<AutonomyAStarState>? currentPath;

  /// Whether or not the rover should replan the path, this is managed by the behavior tree
  bool replanPath = true;

  RoverOrchestrator({required super.collection});

  @override
  Future<void> dispose() async {
    currentPath = null;
    currentCommand = null;
    currentState = AutonomyState.AUTONOMY_STATE_UNDEFINED;
    traversed.clear();
    await super.dispose();
  }

  @override
  Future<void> abort() async {
    currentPath = null;
    return super.abort();
  }

  @override
  void onCommandEnd() {
    super.onCommandEnd();
    currentPath = null;
    replanPath = false;
  }

  @override
  AutonomyData get statusMessage => AutonomyData(
    destination: currentCommand?.destination,
    state: currentState,
    obstacles: [
      ...collection.pathfinder.obstacles,
      ...collection.pathfinder.lockedObstacles,
    ],
    path: {
      ...traversed,
      for (final transition in currentPath ?? <AutonomyAStarState>[])
        transition.position,
    },
    task: currentCommand?.task,
    crash: false, // TODO: Investigate if this is used and how to use it better
  );

  @override
  Message getMessage() => statusMessage;

  /// Triggers a path replan, calling this method will signal the
  /// orchestrator to replan a new path while path following
  void triggerPathReplan() => replanPath = true;

  /// Finds new obstacles and locks them if any intersect with the current path
  ///
  /// If the implementation of the obstacle detector has detected any obstacles,
  /// it will "lock" any obstacles that intersect with the current path, to prevent
  /// future paths from being planned in that area.
  bool findAndLockObstacles() {
    if (!collection.detector.findObstacles()) {
      return false;
    }

    if (currentPath == null) return true;

    final toLock = <GpsCoordinates>{};

    for (final step in currentPath!.map((state) => state.position)) {
      // Since we're iterating over the obstacles that we also want to lock,
      // we have to create a copy of the ones we want to lock, otherwise we'll
      // be modifying the array while iterating over it
      toLock.addAll(
        collection.pathfinder.obstacles.where(
          (obstacle) => collection.pathfinder.isObstacle(step),
        ),
      );
    }

    toLock.forEach(collection.pathfinder.lockObstacle);

    return true;
  }

  Future<bool> calculateAndFollowPath(
    GpsCoordinates goal, {
    bool abortOnError = true,
    bool Function()? alternateEndCondition,
  }) async {
    await collection.drive.resolveOrientation();
    collection.detector.findObstacles();
    while (!collection.gps.coordinates.isNear(goal) &&
        !(alternateEndCondition?.call() ?? false)) {
      // Calculate a path
      collection.logger.debug("Finding a path");
      currentState = AutonomyState.PATHING;
      final path = collection.pathfinder.getPath(goal);
      currentPath = path; // also use local variable path for promotion
      if (path == null) {
        final current = collection.gps.coordinates;
        collection.logger.error(
          "Could not find a path",
          body:
              "No path found from ${current.prettyPrint()} to ${goal.prettyPrint()}",
        );
        if (abortOnError) {
          currentState = AutonomyState.NO_SOLUTION;
          currentCommand = null;
        }
        return false;
      }
      // Try to take that path
      final current = collection.gps.coordinates;
      collection.logger.debug(
        "Found a path from ${current.prettyPrint()} to ${goal.prettyPrint()}: ${path.length} steps",
      );
      collection.logger.debug("Here is a summary of the path");
      for (final step in path) {
        collection.logger.debug(step.toString());
      }
      currentState = AutonomyState.DRIVING;
      var count = 0;
      for (final state in path) {
        collection.logger.debug(state.toString());
        // Alternate end condition may have hit between steps
        if (alternateEndCondition?.call() ?? false) {
          break;
        }
        // Replan if too far from start point
        final distanceError = collection.gps.coordinates.distanceTo(
          state.startPostition,
        );
        if (distanceError >= Constants.replanErrorMeters) {
          collection.logger.info(
            "Replanning Path",
            body: "Rover is $distanceError meters off the path",
          );
          findAndLockObstacles();
          break;
        }
        // Re-align to desired start orientation if angle is too far
        if (state.instruction == DriveDirection.forward) {
          Orientation targetOrientation;
          // if it has RTK, point towards the next coordinate
          if (collection.gps.coordinates.hasRTK) {
            final difference =
                state.position.toUTM() - collection.gps.coordinates.toUTM();

            final angle = atan2(difference.y, difference.x) * 180 / pi;

            targetOrientation = Orientation(z: angle);
          } else {
            targetOrientation = state.orientation.orientation;
          }

          if (!collection.imu.isNear(
            targetOrientation,
            Constants.driveRealignmentEpsilon,
          )) {
            collection.logger.info("Re-aligning IMU to correct orientation");
            await collection.drive.faceOrientation(targetOrientation);
          }
        }
        // If there was an error (usually a timeout) while driving, replan path
        if (!await collection.drive.driveState(state)) {
          findAndLockObstacles();
          break;
        }
        if (currentCommand == null || currentPath == null) {
          collection.logger.info("Aborting path, command was canceled");
          return false;
        }
        traversed.add(state.position);
        // if (state.direction != DriveDirection.forward) continue;
        if (++count >= 5) {
          findAndLockObstacles();
          break;
        }
        final foundObstacle = findAndLockObstacles();
        if (foundObstacle) {
          collection.logger.debug("Found an obstacle. Recalculating path...");
          break; // calculate a new path
        }
      }
    }
    return true;
  }

  @override
  void handleGpsTask(AutonomyCommand command) {
    final destination = command.destination;
    collection.logger.info(
      "Received GPS Task",
      body: "Go to ${destination.prettyPrint()}",
    );
    collection.logger.debug(
      "Currently at ${collection.gps.coordinates.prettyPrint()}",
    );
    traversed.clear();
    collection.drive.setLedStrip(ProtoColor.RED);
    replanPath = false;
    controller.pushState(
      SequenceState(
        controller,
        steps: [
          collection.drive.resolveOrientationState(),
          PathingState(
            controller,
            collection: collection,
            orchestrator: this,
            destination: destination,
          ),
        ],
      ),
    );
    executionTimer = PeriodicTimer(const Duration(milliseconds: 10), (
      timer,
    ) async {
      if (currentCommand == null) {
        collection.logger.warning(
          "Execution timer running while command is null",
          body: "Canceling timer",
        );
        onCommandEnd();
        timer.cancel();
        return;
      }

      if (!controller.hasState()) {
        currentState = AutonomyState.NO_SOLUTION;
        onCommandEnd();
        timer.cancel();
        return;
      }

      controller.update();

      if (collection.gps.isNear(destination, Constants.maxErrorMeters)) {
        timer.cancel();
        collection.logger.info("Task complete");
        onCommandEnd();
        currentState = AutonomyState.AT_DESTINATION;
        collection.drive.setLedStrip(ProtoColor.GREEN, blink: true);
        return;
      }
    });
    // detect obstacles before and after resolving orientation, as a "scan"
    // collection.detector.findObstacles();
    // await collection.drive.resolveOrientation();
    // collection.detector.findObstacles();

    // if (!await calculateAndFollowPath(command.destination)) {
    //   return;
    // }
  }

  @override
  Future<void> handleArucoTask(AutonomyCommand command) async {
    collection.drive.setLedStrip(ProtoColor.RED);

    // Go to GPS coordinates
    collection.logger.info("Got ArUco Task");

    DetectedObject? detectedAruco;

    if (command.destination != GpsCoordinates(latitude: 0, longitude: 0)) {
      if (!await calculateAndFollowPath(
        command.destination,
        abortOnError: false,
      )) {
        collection.logger.error(
          "Failed to follow path towards initial destination",
        );
        currentState = AutonomyState.NO_SOLUTION;
        currentCommand = null;
        return;
      }
    }

    currentState = AutonomyState.SEARCHING;
    collection.logger.info("Searching for ArUco tag");
    final didSeeAruco = await collection.drive.spinForAruco(
      command.arucoId,
      desiredCamera: Constants.arucoDetectionCamera,
    );
    detectedAruco = collection.video.getArucoDetection(
      command.arucoId,
      desiredCamera: Constants.arucoDetectionCamera,
    );

    if (!didSeeAruco || detectedAruco == null) {
      collection.logger.error("Could not find desired Aruco tag");
      currentState = AutonomyState.NO_SOLUTION;
      currentCommand = null;
      return;
    }

    collection.logger.info("Found aruco");
    currentState = AutonomyState.APPROACHING;
    final arucoOrientation = Orientation(
      z: collection.imu.heading - detectedAruco.yaw,
    );
    await collection.drive.faceOrientation(arucoOrientation);
    detectedAruco = await collection.video.waitForAruco(
      command.arucoId,
      desiredCamera: Constants.arucoDetectionCamera,
      timeout: const Duration(seconds: 3),
    );

    if (detectedAruco == null || !detectedAruco.hasBestPnpResult()) {
      // TODO: handle this condition properly
      collection.logger.error(
        "Could not find desired Aruco tag after rotating towards it",
      );
      currentState = AutonomyState.NO_SOLUTION;
      currentCommand = null;
      return;
    }

    collection.logger.debug(
      "Planning path to Aruco ID ${command.arucoId}",
      body: "Detection: ${detectedAruco.toProto3Json()}",
    );

    // In theory we could just find the relative position with the translation x and z,
    // however if the tag's rotation relative to itself is off (which can be common
    // when facing it head on), then it will be extremely innacurate. Since the SolvePnP's
    // distance is always extremely accurate, it is more reliable to use the distance
    // hypotenuse to the camera combined with trig of the tag's angle relative to the camera.
    final cameraToTag = detectedAruco.bestPnpResult.cameraToTarget;
    final distanceToTag =
        sqrt(
          pow(cameraToTag.translation.z, 2) + pow(cameraToTag.translation.x, 2),
        ) -
        1; // don't drive *into* the tag

    if (distanceToTag < 1) {
      // well that was easy
      collection.drive.setLedStrip(ProtoColor.GREEN, blink: true);
      currentState = AutonomyState.AT_DESTINATION;
      currentCommand = null;
      return;
    }

    final relativeX =
        -distanceToTag *
        sin((collection.imu.heading - detectedAruco.yaw) * pi / 180);
    final relativeY =
        distanceToTag *
        cos((collection.imu.heading - detectedAruco.yaw) * pi / 180);

    final destinationCoordinates =
        (collection.gps.coordinates.toUTM() +
                UTMCoordinates(y: relativeY, x: relativeX, zoneNumber: 1))
            .toGps();

    if (!await calculateAndFollowPath(
      destinationCoordinates,
      abortOnError: false,
      alternateEndCondition: () {
        detectedAruco = collection.video.getArucoDetection(
          command.arucoId,
          desiredCamera: Constants.arucoDetectionCamera,
        );
        if (detectedAruco == null) {
          return false;
        }
        final cameraToTag = detectedAruco!.bestPnpResult.cameraToTarget;
        final distanceToTag = sqrt(
          pow(cameraToTag.translation.z, 2) + pow(cameraToTag.translation.x, 2),
        );
        return distanceToTag < 1;
      },
    )) {
      collection.logger.error("Could not spin towards ArUco tag");
      currentState = AutonomyState.NO_SOLUTION;
      currentCommand = null;
      return;
    }
    collection.logger.info("Arrived at estimated Aruco position");
    detectedAruco = collection.video.getArucoDetection(
      command.arucoId,
      desiredCamera: Constants.arucoDetectionCamera,
    );
    if (detectedAruco == null) {
      collection.logger.info("Re-spinning to find Aruco");
      await collection.drive.spinForAruco(
        command.arucoId,
        desiredCamera: Constants.arucoDetectionCamera,
      );
    }

    detectedAruco = collection.video.getArucoDetection(
      command.arucoId,
      desiredCamera: Constants.arucoDetectionCamera,
    );
    if (detectedAruco != null) {
      collection.logger.info("Rotating towards Aruco");
      await collection.drive.faceOrientation(
        Orientation(z: collection.imu.heading - detectedAruco!.yaw),
      );
    } else {
      collection.logger.warning("Could not find Aruco after following path");
    }

    collection.logger.info(
      "Successfully reached within ${Constants.maxErrorMeters} meters of the Aruco tag",
    );
    collection.drive.setLedStrip(ProtoColor.GREEN, blink: true);
    currentState = AutonomyState.AT_DESTINATION;

    currentCommand = null;
  }

  @override
  Future<void> handleHammerTask(AutonomyCommand command) async {}

  @override
  Future<void> handleBottleTask(AutonomyCommand command) async {}
}
