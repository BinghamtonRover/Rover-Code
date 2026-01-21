import "package:autonomy/interfaces.dart";

enum CardinalDirection {
  north(0),
  west(90),
  south(180),
  east(-90),
  northEast(-45),
  northWest(45),
  southWest(180 - 45),
  southEast(180 + 45);

  final double angle;
  const CardinalDirection(this.angle);

  Orientation get orientation => Orientation(z: angle);

  static CardinalDirection nearest(Orientation orientation) {
    var smallestDiff = double.infinity;
    var closestOrientation = CardinalDirection.north;

    for (final value in values) {
      final diff = (value.angle - orientation.z).clampHalfAngle();
      if (diff.abs() < smallestDiff) {
        smallestDiff = diff.abs();
        closestOrientation = value;
      }
    }

    return closestOrientation;
  }

  bool get isPerpendicular => angle.abs() % 90 == 0;

  CardinalDirection turnLeft() => switch (this) {
    north => west,
    west => south,
    south => east,
    east => north,
    northEast => northWest,
    northWest => southWest,
    southWest => southEast,
    southEast => northEast,
  };

  CardinalDirection turnRight() => switch (this) {
    north => east,
    west => north,
    south => west,
    east => south,
    northEast => southEast,
    southEast => southWest,
    southWest => northWest,
    northWest => northEast,
  };

  CardinalDirection turnQuarterLeft() => switch (this) {
    north => northWest,
    northWest => west,
    west => southWest,
    southWest => south,
    south => southEast,
    southEast => east,
    east => northEast,
    northEast => north,
  };

  CardinalDirection turnQuarterRight() => switch (this) {
    north => northEast,
    northEast => east,
    east => southEast,
    southEast => south,
    south => southWest,
    southWest => west,
    west => northWest,
    northWest => north,
  };
}
