import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/weather_repo.dart';

class WeatherSharedPreferences implements WeatherRepo {
  SharedPreferencesAsync prefs = SharedPreferencesAsync();

  @override
  Future<void> updateCities(String json) async {
    await prefs.setString("cities", json);
  }

  @override
  Future<String> getCities() async {
    return await prefs.getString('cities') ?? "";
  }
}
