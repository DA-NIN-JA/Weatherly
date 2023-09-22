import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather_app/services/location.dart';

class APIService {
  // final base = "https://api.openweathermap.org";
  final key = "775779545afc3c2f3df737d4331fd522";
  var name = "";

  Future<Map<String, dynamic>> getLocName() async {
    try {
      LocationData loc = await CurrentLocation().currLoc();
      final url =
          "http://api.openweathermap.org/geo/1.0/reverse?lat=${loc.latitude}&lon=${loc.longitude}&limit=1&appid=${key}";

      http.Response response = await http.get(Uri.parse(url));
      List dataList = jsonDecode(response.body);

      Map<String, dynamic> currWeatherMap = await currWeather(loc);

      if (dataList.isNotEmpty) {
        Map data = dataList.first;
        print(data["name"]);
        
        currWeatherMap["cityName"] = data["name"]; 
        print(currWeatherMap);
        return currWeatherMap;
      } else {
        currWeatherMap["cityName"] = ""; 
        print(currWeatherMap);
        return currWeatherMap;
      }
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> currWeather(LocationData LocData) async {
    try {
      final units = "metric";
      final uri =
          "https://api.openweathermap.org/data/2.5/weather?lat=${LocData!.latitude}&lon=${LocData!.longitude}&units=$units&appid=${key}";
      http.Response response = await http.get(Uri.parse(uri));
      Map<String, dynamic> responseData = jsonDecode(response.body);
      Map<String, dynamic> weather = responseData["weather"].first;
      Map<String, dynamic> wind = responseData["wind"];
      Map<String, dynamic> mainData = responseData["main"];

      Map<String, dynamic> data = {...weather, ...wind, ...mainData};
      print(data);
      return data;
    } catch (e) {
      print(e);
      return {};
    }
  }
}
