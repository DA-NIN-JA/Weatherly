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
      Map<String, dynamic> mainData = responseData["main"];

      Map<String, dynamic> data = {...weather, ...wind, ...mainData};
      print(data);
      return data;
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> filter(List<dynamic> responseData) async{
    List<Map<String, dynamic>> today = [{}];
    DateTime now = DateTime.now();

    for(Map<String, dynamic> mp in responseData){
      DateTime dateTime = DateTime.parse(mp['dt_txt']);
      if(dateTime.day == now.day && dateTime.isAfter(now)){
        today.add(mp);
      }
    }

    today.removeAt(0);

    return today;
  }

  Future<List<Map<String, dynamic>>> todayForecast() async{
    try {
      final units = "metric";
      final uri = "https://api.openweathermap.org/data/2.5/forecast?lat=28.7130324&lon=77.2112818&units=$units&appid=${key}";
      http.Response response = await http.get(Uri.parse(uri));
      final responseData = jsonDecode(response.body);
      futureForecast = responseData;
      List<Map<String, dynamic>> today = await filter(responseData["list"]);
      print(today);
      return today;

    } catch (e) {
      print(e);
      return [{}];
    }
  }
}
