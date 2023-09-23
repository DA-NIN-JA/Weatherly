import 'package:flutter/material.dart';
import '../constants.dart';
import '../services/weather_api.dart';


class ForecastWidget extends StatelessWidget {
  final double lat;
  final double lon;
  const ForecastWidget({
    Key? key,
    required this.lat,
    required this.lon,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: double.infinity,
            width: double.infinity,
          );
        }
        if (snapshot.hasError) {
          return Text("An Error Occured");
        }
        if (snapshot.hasData) {
          final data = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            physics: AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * 0.24,
                          child: Text(
                            data[index]["datetime"],
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Row(
                          children: [
                            Image.network(
                      data[index]["icon"],
                      fit: BoxFit.fill,
                      height: 44,
                      width: 44,
                      errorBuilder: (context, error, stackTrace) {
                        return Text(
                          "Failed to load image!",
                          style: TextStyle(fontSize: 10),
                        );
                      },
                    ),
                            SizedBox(
                              width: 4,
                            ),
                            SizedBox(
                              width: width * 0.12,
                              child: Text(
                                data[index]["conditions"],
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${data[index]["tempmax"]}$d / ${data[index]["tempmin"]}$d",
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
            itemCount: data.length,
          );
        } else {
          return Text("An error occured");
        }
      },
      future: APIService().forecast15(lat, lon),
    );
  }
}