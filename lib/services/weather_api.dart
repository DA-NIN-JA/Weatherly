import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather_app/services/location.dart';

class APIService {
  // final base = "https://api.openweathermap.org";
  final key = "775779545afc3c2f3df737d4331fd522";
  var name = "";
  var LocData;

  Future<String> getLocName() async {
    try {
      LocationData loc = await CurrentLocation().currLoc();
      LocData = loc;
      final url =
          "http://api.openweathermap.org/geo/1.0/reverse?lat=${loc.latitude}&lon=${loc.longitude}&limit=1&appid=${key}";

      http.Response response = await http.get(Uri.parse(url));
      List dataList = jsonDecode(response.body);

      if (dataList.isNotEmpty) {
      Map data = dataList.first;
      print(data["name"]);
      return name = data["name"];
      // return data["name"];
    } else {
      return "Unknown Location";
    }
    } catch (e) {
      print(e);
      return "";
    }
  }
}
