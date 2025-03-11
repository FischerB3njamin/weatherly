import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/pages/detail_page.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/widgets/main_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = true;
  List<Weather> weather = [];
  List<Location> locations = [];
  final weatherController = WeatherController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final String result = await weatherController.getCities();

    if (result.isNotEmpty) {
      final data = jsonDecode(result);
      List<Location> dataList = [];
      for (final item in data) {
        dataList.add(Location.fromJson(item));
      }
      locations = dataList;
      // fetch weather based on locations
      weather = await weatherController.featchWeatherByoLcations(locations, 1);
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SearchAnchor(
                      viewBackgroundColor: Colors.white,
                      builder:
                          (BuildContext context, SearchController controller) {
                        return SearchBar(
                          hintText: "Suche",
                          autoFocus: false,
                          controller: controller,
                          padding: const WidgetStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                          onTap: () {
                            controller.openView();
                          },
                          onChanged: (_) {
                            controller.openView();
                          },
                          leading: const Icon(Icons.search),
                        );
                      },
                      suggestionsBuilder: (BuildContext context,
                          SearchController controller) async {
                        String cityName = controller.text;
                        if (cityName.length > 2) {
                          final result = await weatherController
                              .getCityInformation(cityName);

                          return result.map(
                            (e) => ListTile(
                              title: Text(e.name),
                              subtitle: Text("${e.country}, ${e.state}"),
                              onTap: () async {
                                controller.closeView("");

                                if (locations
                                    .where(
                                        (location) => location.name == e.name)
                                    .isEmpty) {
                                  locations.add(e);
                                  await weatherController
                                      .updateCities(jsonEncode(locations));
                                  _loadData();
                                }
                                if (mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                        city: e.name,
                                        latitude: e.latitude.toString(),
                                        longitude: e.longitude.toString(),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        }
                        return [];
                      },
                    ),
                  ),
                  MainItem(
                      locations: locations,
                      weatherController: weatherController,
                      weather: weather),
                ],
              ),
      ),
    );
  }
}
