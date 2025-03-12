import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/widgets/weather_item.dart';

class MainItem extends StatelessWidget {
  const MainItem({
    super.key,
    required this.locations,
    required this.weatherController,
    required this.weather,
  });

  final List<Location> locations;
  final WeatherController weatherController;
  final List<Weather> weather;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          Column(
            children: [
              for (final location in locations)
                Dismissible(
                  key: Key(location.name),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) async {
                    locations.remove(location);
                    await weatherController.updateCities(jsonEncode(locations));

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${location.name} wurde gelöscht "),
                      ),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  child: WeatherItem(
                      location: location,
                      weather: weather,
                      locations: locations),
                ),
            ],
          )
        ],
      ),
    );
  }
}
