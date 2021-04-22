import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  String displayName;
  double positionLat;
  double positionLong;
  Timestamp time;
  double distance;
  double accuracy;

  Location(
      {@required this.displayName,
      @required this.positionLat,
      @required this.positionLong,
      @required this.time,
      @required this.accuracy});

  double getProximity(double lat, double long) {

    distance = Geolocator.distanceBetween(
      positionLat,
      positionLong,
      lat,
      long,
    );
    return distance;
  }

  String getDisplayName() {
    return displayName;
  }
}
