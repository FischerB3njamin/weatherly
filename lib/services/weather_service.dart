import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/weather_helper.dart';

class WeatherService {
  static const weekdays = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];
  static const locationUrl =
      "https://geocoding-api.open-meteo.com/v1/search?language=de&name=";
  static const weatherURL =
      "https://api.open-meteo.com/v1/forecast?latitude={lat}&longitude={long}&current=temperature_2m&daily=temperature_2m_max%2Ctemperature_2m_min&forecast_days={days}&daily=weather_code";

  static Future<Weather?> featchWeather(
      String lat, String long, int days) async {
    final customUrl = weatherURL
        .replaceAll('{lat}', lat)
        .replaceAll('{long}', long)
        .replaceAll('{days}', days.toString());
    final response = await get(Uri.parse(customUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Weather weather = Weather.fromJson(data);
      Forecast forecast = Forecast();
      List.generate(days, (index) {
        DateTime date = DateTime.parse(data['daily']['time'][index]);
        String weekdayName = weekdays[date.weekday - 1];

        forecast.days.add(weekdayName);
        forecast.minTemp.add(data['daily']['temperature_2m_min'][index]);
        forecast.maxTemp.add(data['daily']['temperature_2m_max'][index]);
        forecast.imagePaths.add(WeatherHelper.getWeatherImage(
            data['daily']['weather_code'][index]));
      });
      weather.forecast = forecast;
      return weather;
    }
    return null;
  }

  static Future<List<Weather>> featchWeatherByoLcations(
    List<Location> locations,
    int days,
  ) async {
    String lat = "";
    String long = "";
    List<Weather> resultList = [];

    for (final location in locations) {
      lat += "${location.latitude},";
      long += "${location.longitude},";
    }

    final customUrl = weatherURL
        .replaceAll('{lat}', lat)
        .replaceAll('{long}', long)
        .replaceAll('{days}', days.toString());
    final response = await get(Uri.parse(customUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      resultList.addAll(data.map((e) => Weather.fromJson(e)).toList());
    }
    return resultList;
  }

  static Future<List<Location>> getCityInformation(String cityname) async {
    final result = await get(Uri.parse("$locationUrl$cityname"));
    final List<Location> resultList = [];

    if (result.statusCode == 200) {
      final data = json.decode(result.body);
      for (final item in data['results']) {
        resultList.add(Location.fromJson(item));
      }
    }

    return resultList;
  }
}
