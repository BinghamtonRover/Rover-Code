# Autonomy (Dart)

This repository holds code to operate the rover autonomously. 

## Running the code

To run the code, simply run
```
dart run
```

## Requirements

### Competition Requirements

In the Autonomous Navigation mission, we will be given a few "waypoints" that the rover must navigate to: 

1. An exact GPS coordinate. The rover must get as close as possible to the coordinate.
2. An approximate GPS coordinate with a visual marker (see below). The rover must drive to the coordinate given, then improve its accuracy by finding and approaching the marker.
3. An approximate GPS coordinate with two visual markers. The rover must drive to the coordinate given, then drive in between the posts without touching either one.

### Code requirements

The rover must

- Communicate with the dashboard
- Start navigating to a waypoint when instructed to via an `AutonomyCommand` 
- Report on its environment and planned path via `AutonomyData` messages
- Read its GPS coordinates and inclination (see below)
- Handle possible errors and automatically abort
- Indicate when it has arrived at a waypoint by flashing the LED bar and sending a message to the dashboard
- Read and stream the RealSense data to the dashboard

## Obstacle avoidance and path planning

### Getting to the given coordinates: A*

To get to the given coordinates, we use the [A*](https://en.wikipedia.org/wiki/A*_search_algorithm) path-planning algorithm. This yields a path from our current coordinates to the destination in a birds-eye-view grid (that is, 2D). The rover should drive along this path and report it to the dashboard

### Obstacle detection

We have a RealSense Depth Camera that can detect obstacles directly in fron of the rover, such as a nearby hill or boulder. When such an obstacle is detected, we add it to the A* grid and re-run the path-planning to generate a path around the obstacle. This also includes scanning the ground for possible drops, so we don't run off a cliff. Because we need to use the RealSense API, we must take control of the camera from the [Video](https://github.com/BinghamtonRover/Video) program.

### Inclination detection

More important than avoiding obstacles in the barren desert is keeping the rover level. We use an onboard IMU to detect our orientation and if we incline more than 30 degrees up or down, report our current location as an "obstacle" on the map and plan a path around it. We should also report multiple nearby squares so as to bias the A* algorithm to go backwards. Seeing a hill from afar using the RealSense will help us avoid this scenario.

## Marker detection

The markers are [ArUco](https://docs.opencv.org/4.x/d5/dae/tutorial_aruco_detection.html)

### One marker

When we have arrived at the GPS destination, the rover marks out a large 20m x 20m square and drives up and down to cover the entire area. While doing so, we use OpenCV's `aruco` library to detect any markers in our field of view (see the link above). Once we have found one, we approximate its location using our current position, orientation, and distance to the marker. Then we set our destination to the marker's coordinates and drive to it. 

We may also consider driving towards the marker using visual cues rather than GPS-based: turn until the marker is centered, drive straight, and stop when the marker is some distance away. This would get us closer to the marker and avoid hitting it compared to the GPS approach, but might fail to navigate around obstacles. We should probably consider a combined approach.

### Two markers (a gate)

The procedure is the same as as above but when we detect a marker, we turn slightly until we detect the second marker as well (which will have a distinct ArUco ID). We then calculate GPS coordinates of the two markers and calculate the midpoint between the two and navigate to the midpoint instead. We then drive a small distance forward to say we have driven "through" the gate. 

Similar to the above, we will need to take visual cues into account to ensure we drive through the gate and not hit either post.
