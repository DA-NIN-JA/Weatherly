import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';

import '../grid_card.dart';

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
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2)
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
                      "Mukherjee Nagar",
                      style: TextStyle(
                          fontSize: 28, color: kwhite, fontFamily: "Raleway"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "37°C",
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
                      children: [
                        Text(
                          "Fri",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text("37° / 29°",
                            style: Theme.of(context).textTheme.displaySmall)
                      ],
                    ),
                    Text("Haze",
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
                      color: Colors.grey.shade800.withOpacity(0.5)),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    physics: AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "12:00 PM",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Icon(
                              Icons.sunny,
                              color: kwhite,
                            ),
                            Text(
                              "32$d",
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ],
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: 24,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: height * 0.52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade800.withOpacity(0.5)),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Today",
                                  style: Theme.of(context).textTheme.bodyMedium,
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
                                            .bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "36$d / 28$d",
                                  style: Theme.of(context).textTheme.bodyMedium,
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
                SizedBox(height: 40,),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 8,),
                        Text("Weather Details", style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GridCard(heading: "Humidity", height: height, width: width,icon: Icons.air_rounded,value: "66%"),
                            GridCard(heading: "Feels Like", height: height, width: width,icon: Icons.air_rounded,value: "39$d"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GridCard(heading: "AQI", height: height, width: width,icon: Icons.air_rounded,value: "78"),
                            GridCard(heading: "Air Pressure", height: height, width: width,icon: Icons.air_rounded,value: "1004"),
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
}
