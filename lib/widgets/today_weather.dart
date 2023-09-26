import 'package:flutter/material.dart';
import '../services/weather_api.dart';
import 'package:intl/intl.dart';
import '../constants.dart';


class TodayWeather extends StatelessWidget {
  final double lat;
  final double long;

  const TodayWeather({super.key, required this.lat, required this.long});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: double.infinity,
          );
        }
        if (snapshot.hasError) {
          return Text("An Error Occured");
        }
        if (snapshot.data != null) {
          final data = snapshot.data;
          return ListView.builder(
            padding: EdgeInsets.all(0),
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        DateFormat.jm()
                            .format(DateTime.parse(data[index]["dt_txt"])),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Image.network(
                        data[index]["weather"][0]["icon"],
                        // fit: BoxFit.scaleDown,
                        height: 64,
                        width: 64,
                        errorBuilder: (context, error, stackTrace) {
                          return Text(
                            "Failed to load image!",
                            style: TextStyle(fontSize: 10),
                          );
                        },
                      ),
                      Text(
                        "${(data[index]["main"]["temp"]).round()}$d",
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
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
      future: APIService().todayForecast(lat, long),
    );
  }
}
