import 'package:flutter/material.dart';

const partCloudy = Color.fromRGBO(107, 197, 253, 1);
const sunny = Color.fromRGBO(255, 215, 0, 1);
const cloudy = Color.fromRGBO(169, 169, 169, 1);
const overcast = Color.fromRGBO(128, 128, 128, 1);
const mist = Color.fromRGBO(190, 190, 190, 1);
const rain = Color.fromRGBO(70, 130, 180, 1);
const snow = Color.fromRGBO(195, 195, 195, 1);
const windy = Color.fromRGBO(0, 206, 209, 1);
const kwhite = Color.fromARGB(255, 224, 224, 224);
const kblack = Color.fromARGB(255, 66, 66, 66);
const d = "°"; 

// {id: 721, main: Haze, description: haze, icon: 50n, speed: 2.57, deg: 270, temp: 33.11, feels_like: 38.06, temp_min: 33.11, temp_max: 33.11, pressure: 1005, humidity: 55, cityName: Model Town Tehsil,}

// [{dt: 1695438000, main: {temp: 31.57, feels_like: 34.77, temp_min: 31.57, temp_max: 31.57, pressure: 1007, sea_level: 1007, grnd_level: 984, humidity: 55, temp_kf: 0}, weather: [{id: 500, main: Rain, description: light rain, icon: 10d}], clouds: {all: 5}, wind: {speed: 2.32, deg: 174, gust: 2.93}, visibility: 10000, pop: 0.51, rain: {3h: 0.2}, sys: {pod: d}, dt_txt: 2023-09-23 03:00:00}, {dt: 1695448800, main: {temp: 36.17, feels_like: 39.49, temp_min: 36.17, temp_max: 36.17, pressure: 1006, sea_level: 1006, grnd_level: 983, humidity: 40, temp_kf: 0}, weather: [{id: 800, main: Clear, description: clear sky, icon: 01d}], clouds: {all: 6}, wind: {speed: 0.84, deg: 201, gust: 2.44}, visibility: 10000, pop: 0.51, sys: {pod: d}, dt_txt: 2023-09-23 06:00:00}, {dt: 1695459600, main: {temp: 35.63, feels_like: 37.77, temp_min: 35.63, temp_max: 35.63, pressure: 1003, sea_level: 1003, grnd_level: 980, humidity: 38, temp_kf: 0}, weather: [{id: 500, main: Rain, description: light rain, icon: 10d}], clouds: {all: 69}, win