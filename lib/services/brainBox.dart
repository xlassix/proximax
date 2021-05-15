import 'dart:math';

//convert degrees to rads
double degreesToRadians(degree) {
  return degree * pi / 180.0;
}

// proximity calculator in Meters
double distanceInmetres(List<double> _from, List<double> _to) {
  double radiusEarthMeters = 6371008.8;
  double lat1 = _from[0];
  double lon1 = _from[1];
  double lat2 = _to[0];
  double lon2 = _to[1];
  double dLat = degreesToRadians(lat2 - lat1);
  double dLon = degreesToRadians(lon2 - lon1);

  lat1 = degreesToRadians(lat1);
  lat2 = degreesToRadians(lat2);
  double a = sin(dLat / 2) * sin(dLat / 2) +
      sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return radiusEarthMeters * c;
}
