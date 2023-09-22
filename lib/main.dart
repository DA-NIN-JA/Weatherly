import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import './screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weatherly",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        useMaterial3: true,
        // colorScheme: ColorScheme.fromSeed(seedColor: rain),
        scaffoldBackgroundColor: partCloudy.withOpacity(0.7),
        textTheme: TextTheme(
          displaySmall: TextStyle(
            fontSize: 18,
            fontFamily: "JosefinSlab",
            color: kwhite,
          ),
          displayMedium: TextStyle(
            fontSize: 24,
            fontFamily: "JosefinSlab",
            color: kwhite,
          ),
          bodySmall:
              TextStyle(fontFamily: "Raleway", fontSize: 14, color: kwhite),
          bodyMedium:
              TextStyle(fontFamily: "RobotoSlab", fontSize: 15, color: kwhite),
          labelSmall: TextStyle(
            fontFamily: "Raleway",
            fontSize: 14,
            color: kwhite.withOpacity(0.6),
          ),
          labelMedium: TextStyle(
            fontFamily: "RobotoSlab",
            fontSize: 28,
            color: kwhite,
          ),
        ),
      ),
    );
  }
}
