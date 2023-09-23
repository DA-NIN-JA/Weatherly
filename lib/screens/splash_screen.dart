import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../widgets/grid_card.dart';
import '../constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            splash.withOpacity(0.7).withOpacity(0.2),
            splash.withOpacity(0.7).withOpacity(0.4),
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
                    Text(
                      "",
                      style: TextStyle(
                          fontSize: 28, color: kwhite, fontFamily: "Raleway"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Text(
                  "Working on it!!",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.normal,
                    color: kwhite,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kwhite),
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text("", style: Theme.of(context).textTheme.displayMedium),
                    Text(
                      DateFormat("EEE, MMM, dd").format(DateTime.now()),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: height * 0.14,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: partCloudy.withOpacity(0.7).withOpacity(0.01),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 16,
                            spreadRadius: 4,
                            blurStyle: BlurStyle.outer)
                      ]),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: height * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: partCloudy.withOpacity(0.7).withOpacity(0.01),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 16,
                            spreadRadius: 4,
                            blurStyle: BlurStyle.outer)
                      ]),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GridCard(
                                heading: "Humidity",
                                height: height,
                                width: width,
                                icon: FontAwesomeIcons.droplet,
                                value: "",
                                unit: "%",
                                bgColor: partCloudy.withOpacity(0.7)),
                            GridCard(
                                heading: "Feels Like",
                                height: height,
                                width: width,
                                icon: FontAwesomeIcons.temperature4,
                                value: "",
                                unit: "${d}C",
                                bgColor: partCloudy.withOpacity(0.7)),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GridCard(
                                heading: "Wind",
                                height: height,
                                width: width,
                                icon: FontAwesomeIcons.wind,
                                value: "",
                                unit: "m/s",
                                bgColor: partCloudy.withOpacity(0.7)),
                            GridCard(
                                heading: "Air Pressure",
                                height: height,
                                width: width,
                                icon: FontAwesomeIcons.arrowsDownToLine,
                                value: "",
                                unit: "hPa",
                                bgColor: partCloudy.withOpacity(0.7)),
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
