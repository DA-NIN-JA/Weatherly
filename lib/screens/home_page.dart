import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:weather_app/constants.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/services/weather_api.dart';

import '../widgets/forecast.dart';
import '../widgets/grid_card.dart';
import '../widgets/today_weather.dart';

class HomePage extends StatefulWidget {
  double? tempMin;
  double? tempMax;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void setMinMaxTemp(double minTemp, double maxTemp) {
    setState(() {
      widget.tempMin = minTemp;
      widget.tempMax = maxTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return SplashScreen(height: height, width: width);
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("An error Occured"),
            ),
          );
        } else {
          final data = snapshot.data;
          var bgColor = partCloudy;
          switch (data?["main"]) {
            case "Thunderstorm":
              bgColor = overcast.withOpacity(0.7);
              break;
            case "Drizzle":
              bgColor = partCloudy.withOpacity(0.7);
              break;
            case "Rain":
              bgColor = partCloudy.withOpacity(0.7);
              break;
            case "Snow":
              bgColor = snow.withOpacity(0.7);
              break;
            
            case "Clear":
              if (DateTime.now().hour < 18) {
                bgColor = sunny.withOpacity(0.7);
                break;
              } else {
                bgColor = night.withOpacity(0.7);
              }

            case "Clouds":
              bgColor = cloudy.withOpacity(0.7);
              break;
            case "Haze":
              bgColor = mist.withOpacity(0.7);
              break;
            case "Mist":
              bgColor = mist.withOpacity(0.7);
              break;
            case "Smoke":
              bgColor = mist.withOpacity(0.7);
              break;
            case "Dust":
              bgColor = mist.withOpacity(0.7);
              break;
            case "Fog":
              bgColor = mist.withOpacity(0.7);
              break;
            case "Sand":
              bgColor = sunny.withOpacity(0.4);
              break;
            case "Ash":
              bgColor = mist.withOpacity(0.7);
              break;
            case "Squall":
              bgColor = mist.withOpacity(0.7);
              break;
            case "Tornado":
              bgColor = overcast.withOpacity(0.7);
              break;
            default:
              bgColor = partCloudy.withOpacity(0.7);
          }
          return Scaffold(
            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  bgColor.withOpacity(0),
                  bgColor.withOpacity(0.2)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: kwhite,
                              size: 32,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              data?["cityName"] as String,
                              style: TextStyle(
                                  fontSize: 28,
                                  color: kwhite,
                                  fontFamily: "Raleway",
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "${(data?["temp"]).round()}°C",
                        style: TextStyle(
                          fontSize: 120,
                          fontFamily: "RobotoSlab",
                          fontWeight: FontWeight.bold,
                          color: kwhite,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            data?["main"],
                            style: Theme.of(context).textTheme.displayMedium,
                            maxLines: 1,
                          ),
                          Text(
                            DateFormat("EEE, MMM, dd").format(DateTime.now()),
                            style: Theme.of(context).textTheme.displayMedium,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: height * 0.14,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: bgColor.withOpacity(0.01),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 16,
                                  spreadRadius: 4,
                                  blurStyle: BlurStyle.outer)
                            ]),
                        child: TodayWeather(
                          lat: data?["lat"],
                          long: data?["lon"],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: height * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: bgColor.withOpacity(0.01),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 16,
                                  spreadRadius: 4,
                                  blurStyle: BlurStyle.outer)
                            ]),
                        child: ForecastWidget(
                          width: width,
                          lat: data?["lat"],
                          lon: data?["lon"],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Text("Weather Details",
                                  style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GridCard(
                                      heading: "Humidity",
                                      height: height,
                                      width: width,
                                      icon: FontAwesomeIcons.droplet,
                                      value: "${data?["humidity"]}",
                                      unit: "%",
                                      bgColor: bgColor),
                                  GridCard(
                                      heading: "Feels Like",
                                      height: height,
                                      width: width,
                                      icon: FontAwesomeIcons.temperature4,
                                      value:
                                          "${(data?["feels_like"]).round()}",
                                      unit: "${d}C",
                                      bgColor: bgColor),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GridCard(
                                      heading: "Wind",
                                      height: height,
                                      width: width,
                                      icon: FontAwesomeIcons.wind,
                                      value:
                                          "${data?["speed"].toStringAsFixed(2)}",
                                      unit: "m/s",
                                      bgColor: bgColor),
                                  GridCard(
                                      heading: "Air Pressure",
                                      height: height,
                                      width: width,
                                      icon: FontAwesomeIcons.arrowsDownToLine,
                                      value: "${data?["pressure"]}",
                                      unit: "hPa",
                                      bgColor: bgColor),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
      future: APIService().getLocName(),
    );
  }
}
