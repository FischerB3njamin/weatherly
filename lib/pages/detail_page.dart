import 'package:flutter/material.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/widgets/weather_forecast.dart';

class DetailPage extends StatefulWidget {
  final String latitude;
  final String longitude;
  final String city;

  const DetailPage({
    super.key,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Weather? weather;
  bool isLoading = true;
  WeatherController controller = WeatherController();

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData() async {
    weather = await controller.featchWeather(
      widget.latitude,
      widget.longitude,
      16,
    );
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city),
        actions: [
          IconButton(
            onPressed: () {
              setState(() => isLoading = true);
              _loadData();
            },
            icon: Icon(
              Icons.refresh,
              size: 32,
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Daten werden geladen für ${widget.city}"),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : Center(
              child: weather != null
                  ? ListView(
                      children: [
                        SizedBox(height: 32),
                        weather!.imagePath?.image(width: 100, height: 100) ??
                            SizedBox.shrink(),
                        Text(
                          textAlign: TextAlign.center,
                          "${weather!.temp}${weather!.unit}",
                          style: TextStyle(fontSize: 48),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "H:${weather!.maxTemp}${weather!.unit}",
                              style: TextTheme.of(context).bodyLarge,
                            ),
                            SizedBox(width: 32),
                            Text(
                              "T:${weather!.minTemp}${weather!.unit}",
                              style: TextTheme.of(context).bodyLarge,
                            ),
                          ],
                        ),
                        SizedBox(height: 60),
                        ...List.generate(
                            16,
                            (index) => WeatherForecast(
                                weather: weather, index: index)),
                      ],
                    )
                  : Text("Kein Wetter gefunden"),
            ),
    );
  }
}
