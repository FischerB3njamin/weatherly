import 'package:flutter/material.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/pages/detail_page.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({
    super.key,
    required this.location,
    required this.weather,
    required this.locations,
  });

  final Location location;
  final List<Weather> weather;
  final List<Location> locations;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(location.name),
      subtitle: Text("${location.country}, ${location.state}"),
      leading: weather[locations.indexOf(location)]
              .imagePath
              ?.image(width: 30, height: 30) ??
          SizedBox.shrink(),
      trailing: Text(
        "${weather[locations.indexOf(location)].temp}${weather[locations.indexOf(location)].unit}",
        style: TextTheme.of(context).bodyLarge,
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(
            city: location.name,
            latitude: location.latitude.toString(),
            longitude: location.longitude.toString(),
          ),
        ),
      ),
    );
  }
}
