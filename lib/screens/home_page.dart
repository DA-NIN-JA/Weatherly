import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/services/weather_api.dart';

import '../widgets/grid_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
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
            case "rain":
              bgColor = partCloudy.withOpacity(0.7);
              break;
            case "Snow":
              bgColor = snow.withOpacity(0.7);
              break;
            case "Mist":
              bgColor = mist.withOpacity(0.7);
              break;
            case "Clear":
              bgColor = sunny.withOpacity(0.7);
              break;
            case "Clouds":
              bgColor = cloudy.withOpacity(0.7);
              break;
            case "Haze":
              bgColor = mist.withOpacity(0.7);
              break;
            default:
              bgColor = partCloudy.withOpacity(0.7);
          }
          return Scaffold(
            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  bgColor.withOpacity(0.2),
                  bgColor.withOpacity(0.4)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
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
                                fontFamily: "Raleway"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "${(data?["temp"] as double).round()}°C",
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                "Fri",
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                  "${(data?["temp_max"] as double).round()}° / ${(data?["temp_min"] as double).round()}° C",
                                  style:
                                      Theme.of(context).textTheme.displaySmall)
                            ],
                          ),
                          Text(data?["main"],
                              style: Theme.of(context).textTheme.displayMedium),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: height * 0.14,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade800.withOpacity(0.5),boxShadow: [BoxShadow(blurRadius: 16, spreadRadius: 4,blurStyle: BlurStyle.outer)]),
                        child: TodayWeather(),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: height * 0.52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade800.withOpacity(0.5),
                          boxShadow: [BoxShadow(blurRadius: 16, spreadRadius: 4,blurStyle: BlurStyle.outer)]
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Today",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.cloud,
                                            color: kwhite,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          SizedBox(
                                            width: width * 0.24,
                                            child: Text(
                                              "Partly Cloudy",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "36$d / 28$d",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: kwhite.withOpacity(0.3),
                                  )
                                ],
                              ),
                            );
                          },
                          scrollDirection: Axis.vertical,
                          itemCount: 7,
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
                                      icon: Icons.air_rounded,
                                      value: "${data?["humidity"]}",
                                      unit: "%"),
                                  GridCard(
                                      heading: "Feels Like",
                                      height: height,
                                      width: width,
                                      icon: Icons.air_rounded,
                                      value:
                                          "${(data?["feels_like"] as double).round()}",
                                      unit: "${d}C"),
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
                                      icon: Icons.air_rounded,
                                      value:
                                          "${data?["speed"].toStringAsFixed(2)}",
                                      unit: "m/s"),
                                  GridCard(
                                      heading: "Air Pressure",
                                      height: height,
                                      width: width,
                                      icon: Icons.air_rounded,
                                      value: "${data?["pressure"]}",
                                      unit: "hPa"),
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

class TodayWeather extends StatelessWidget {
  const TodayWeather({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(width: double.infinity,);
        }
        if (snapshot.hasError) {
          return Text("An Error Occured");
        }
        if (snapshot.data != null) {
          final data = snapshot.data;
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      DateFormat.jm()
                          .format(DateTime.parse(data[index]["dt_txt"])),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Icon(
                      Icons.sunny,
                      color: kwhite,
                    ),
                    Text(
                      "${(data[index]["main"]["temp"] as double).round()}$d",
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
              );
            },
            scrollDirection: Axis.horizontal,
            itemCount: data!.length,
          );
        } else {
          return Text("An Error");
        }
      },
      future: APIService().todayForecast(),
    );
  }
}
