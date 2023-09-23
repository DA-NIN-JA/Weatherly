import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';

class GridCard extends StatelessWidget {
  final double height;
  final double width;
  final String heading;
  final String value;
  final IconData icon;
  final String unit;

  GridCard({
    required this.height,
    required this.width,
    required this.heading,
    required this.value,
    required this.icon,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      height: height * 0.18,
      width: height * 0.18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade800.withOpacity(0.6),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 1,
            blurStyle: BlurStyle.outer,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 32,
            color: kwhite,
          ),
          Text(
            heading,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          // SizedBox(height: 8,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                unit,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
