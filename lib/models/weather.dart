import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/weather_helper.dart';

class Weather {
  double temp;
  double maxTemp;
  double minTemp;
  String unit;
  String latitude;
  String longitude;
  AssetGenImage? imagePath;
  Forecast? forecast;

  Weather({
    required this.maxTemp,
    required this.minTemp,
    required this.temp,
    required this.unit,
    required this.imagePath,
    required this.latitude,
    required this.longitude,
  });

  Weather.fromJson(Map<String, dynamic> json)
      : maxTemp = json["daily"]["temperature_2m_max"][0],
        minTemp = json["daily"]["temperature_2m_min"][0],
        temp = json["current"]["temperature_2m"],
        unit = json["current_units"]["temperature_2m"],
        latitude = json["latitude"].toString(),
        longitude = json["longitude"].toString(),
        imagePath = WeatherHelper.getWeatherImage(
            json['daily']["weather_code"][0] as int);
}
