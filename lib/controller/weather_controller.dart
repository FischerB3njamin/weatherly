import 'package:weather_app/data/weather_repo.dart';
import 'package:weather_app/data/weather_shared_preferences.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherController {
  WeatherRepo repo = WeatherSharedPreferences();
  Future<void> updateCities(String json) => repo.updateCities(json);
  Future<String> getCities() => repo.getCities();
  Future<Weather?> featchWeather(String latitude, String longitude, int days) =>
      WeatherService.featchWeather(latitude, longitude, 16);

  Future<List<Location>> getCityInformation(String cityname) =>
      WeatherService.getCityInformation(cityname);

  Future<List<Weather>> featchWeatherByoLcations(
    List<Location> locations,
    int days,
  ) =>
      WeatherService.featchWeatherByoLcations(
        locations,
        days,
      );
}
