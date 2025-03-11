import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';

class WeatherForecast extends StatelessWidget {
  final int index;
  const WeatherForecast(
      {super.key, required this.weather, required this.index});

  final Weather? weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(32),
          border: Border(
              bottom: BorderSide(color: Colors.black.withAlpha(20), width: 3))),
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            weather!.forecast?.days[index] ?? "Keine Daten",
            style: TextTheme.of(context)
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          weather!.forecast?.imagePaths[index]?.image(width: 50, height: 50) ??
              SizedBox.shrink(),
          Text(
            weather!.forecast?.minTemp[index].toString() ?? "hello",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          Text(
            weather!.forecast?.maxTemp[index].toString() ?? "hello",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
