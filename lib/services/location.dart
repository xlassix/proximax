import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';



class Location {
  String displayName;
  double positionLat;
  double positionLong;
  DateTime time;
  
  Location(
      {@required displayName,
      @required positionLat,
      @required positionLong,
      @required time});

  double getProximity(double lat,double long) {
    return Geolocator.distanceBetween(lat, long, positionLat, positionLat);
  }
}
