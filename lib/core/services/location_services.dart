import 'package:geolocator/geolocator.dart';

enum StatuesPermission {
  serverLocationNotEnabeld,
  serverLocationEnabeldAndPermission,
  permissionDenied,
  deniedForever,
}

class LocationServices {
  Future<StatuesPermission> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        return StatuesPermission.permissionDenied;
      }
      if (permission == LocationPermission.deniedForever) {
        return StatuesPermission.deniedForever;
      }
    }
    if (!serviceEnabled) {
      return StatuesPermission.serverLocationNotEnabeld;
    }
    if (serviceEnabled &&
        (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always)) {
      return StatuesPermission.serverLocationEnabeldAndPermission;
    } else {
      return StatuesPermission.serverLocationNotEnabeld;
    }
  }

  Future<Position> getPosition() async {
    return await Geolocator.getCurrentPosition();
  }
}
