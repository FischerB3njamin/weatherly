abstract class WeatherRepo {
  Future<void> updateCities(String json);
  Future<String> getCities();
}
