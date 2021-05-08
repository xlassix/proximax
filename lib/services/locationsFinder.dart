import 'package:geolocator/geolocator.dart';

//location library and initialisation

class LocationFinder {
  double latitude;
  double longitude;

  void getPermission() async {
    // initialise notification 
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
  }

  Future<Position> getCurrentLocation() async {
    await getPermission();
    Position positionInstance = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    latitude = positionInstance.latitude;
    longitude = positionInstance.longitude;
    return positionInstance;
  }
}
