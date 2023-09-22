// import 'package:flutter/material.dart';
import 'package:location/location.dart';

class CurrentLocation {

  Future<LocationData> currLoc() async {
    try {
      var granted = await Location().hasPermission();
      if (granted == PermissionStatus.denied) {
        granted = await Location().requestPermission();
        if (granted == PermissionStatus.denied) {
          return LocationData.fromMap({});
        }
      }

      final locData = await Location().getLocation();
      print(locData.latitude);
      print(locData.longitude);

      return locData;
    } catch (e) {
      print(e);
      return LocationData.fromMap({});
    }
  }
}
