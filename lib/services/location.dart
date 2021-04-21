import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  String displayName;
  double positionLat;
  double positionLong;
  Timestamp time;
  double distance;

  Location(
      {@required this.displayName,
      @required this.positionLat,
      @required this.positionLong,
      @required this.time});

  double getProximity(double lat, double long) {
    distance = Geolocator.distanceBetween(lat, long, positionLat, positionLat);
    return distance;
  }

  String getDisplayName() {
    return displayName;
  }
}
