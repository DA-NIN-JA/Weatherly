import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather_app/services/location.dart';
import 'package:intl/intl.dart';
import 'key.dart';

class APIService {
  // final base = "https://api.openweathermap.org";

  var name = "";
  var futureForecast;

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
      Map<String, dynamic> location = responseData["coord"];
      Map<String, dynamic> mainData = responseData["main"];

      Map<String, dynamic> data = {
        ...location,
        ...weather,
        ...wind,
        ...mainData
      };
      // print(data);
      return data;
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> filter(List<dynamic> responseData) async {
    List<Map<String, dynamic>> today = [{}];
    DateTime now = DateTime.now();

    for (Map<String, dynamic> mp in responseData) {
      DateTime dateTime = DateTime.parse(mp['dt_txt']);
      if (dateTime.isAfter(now) &&
          dateTime.isBefore(
            now.add(
              Duration(days: 1),
            ),
          )) {
        mp["weather"][0]["icon"] =
            "https://openweathermap.org/img/wn/${mp["weather"][0]["icon"]}@2x.png";
        today.add(mp);
      }
    }

    today.removeAt(0);

    return today;
  }

  Future<List<Map<String, dynamic>>> todayForecast(
      double lat, double lon) async {
    try {
      final units = "metric";
      final uri =
          "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=$units&appid=${key}";
      http.Response response = await http.get(Uri.parse(uri));
      final responseData = jsonDecode(response.body);
      futureForecast = responseData;
      List<Map<String, dynamic>> today = await filter(responseData["list"]);
      // print(today);
      return today;
    } catch (e) {
      print(e);
      return [{}];
    }
  }

  String toUrl(String id){
    switch (id) {
      case "snow":
        return "https://openweathermap.org/img/wn/13d@2x.png";
      case "rain":
        return "https://openweathermap.org/img/wn/10d@2x.png";
      case "fog":
        return "https://openweathermap.org/img/wn/50d@2x.png";
      case "cloudy":
        return "https://openweathermap.org/img/wn/04d@2x.png";
      case "partly-cloudy-day":
        return "https://openweathermap.org/img/wn/02d@2x.png";
      case "partly-cloudy-night":
        return "https://openweathermap.org/img/wn/02n@2x.png";
      case "clear-day":
        return "https://openweathermap.org/img/wn/01d@2x.png";
      case "clear-night":
        return "https://openweathermap.org/img/wn/01n@2x.png";
      default:
        return "";
    }
  }

  List<Map<String, dynamic>> filterData(List<dynamic> data) {
    List<Map<String, dynamic>> days = [{}];
    final date = DateTime.now();
    for (var day in data) {
      Map<String, dynamic> curr = {};
      curr["tempmax"] = day["tempmax"];
      curr["tempmin"] = day["tempmin"];
      // curr["datetime"] = day["datetime"];
      curr["conditions"] = day["conditions"];
      curr["icon"] = toUrl(day["icon"]);
      if (day["datetime"] == DateFormat('yyyy-MM-dd').format(date)) {
        curr["datetime"] = "Today";
      } else if (day["datetime"] ==
          DateFormat('yyyy-MM-dd').format(date.add(Duration(days: 1)))) {
        curr["datetime"] = "Tomorrow";
      } else {
        curr["datetime"] =
            DateFormat('EEEE').format(DateTime.parse(day["datetime"]));
      }
      days.add(curr);
    }

    days.removeAt(0);

    return days;
  }

  Future<List<dynamic>> forecast15(double lat, double lon) async {
    try {
      final units = "metric";
      final date = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final lastDate = DateTime.now().add(Duration(days: 7));
      final endDate = DateFormat('yyyy-MM-dd').format(lastDate);

      final uri =
          "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$lat%2C$lon/$date/$endDate?unitGroup=$units&key=${key2}";
      http.Response response = await http.get(Uri.parse(uri));
      final responseData = jsonDecode(response.body);
      List<dynamic> days = responseData["days"];
      days = filterData(days);
      print(days);
      return days;
    } catch (e) {
      print(e);
      return [{}];
    }
  }
}
