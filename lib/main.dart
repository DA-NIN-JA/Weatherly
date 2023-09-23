import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:weather_app/constants.dart';
import './screens/home_page.dart';

void main() {
  // FlutterNativeSplash.remove();
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const MyApp()));
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
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          displaySmall: TextStyle(
              fontSize: 18,
              fontFamily: "JosefinSlab",
              color: kwhite,
              overflow: TextOverflow.ellipsis),
          displayMedium: TextStyle(
              fontSize: 22,
              fontFamily: "Raleway",
              color: kwhite,
              overflow: TextOverflow.ellipsis),
          bodySmall: TextStyle(
              fontFamily: "Raleway",
              fontSize: 14,
              color: kwhite,
              overflow: TextOverflow.ellipsis),
          bodyMedium: TextStyle(
              fontFamily: "RobotoSlab",
              fontSize: 14,
              color: kwhite,
              overflow: TextOverflow.ellipsis),
          labelSmall: TextStyle(
              fontFamily: "Raleway",
              fontSize: 14,
              color: kwhite.withOpacity(0.6),
              overflow: TextOverflow.ellipsis),
          labelMedium: TextStyle(
              fontFamily: "RobotoSlab",
              fontSize: 28,
              color: kwhite,
              overflow: TextOverflow.ellipsis),
          titleSmall: TextStyle(
              fontFamily: "RobotoSlab",
              fontSize: 14,
              color: kwhite,
              overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
