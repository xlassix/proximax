import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  String displayName;
  double positionLat;
  double positionLong;
  Timestamp time;

  Location(
      {@required  this.displayName,
      @required this.positionLat,
      @required this.positionLong,
      @required this.time});

  double getProximity(double lat, double long) {
    return Geolocator.distanceBetween(lat, long, positionLat, positionLat);
  }

  String getDisplayName() {
    return displayName;
  }
}
