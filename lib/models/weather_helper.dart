import 'package:weather_app/gen/assets.gen.dart';

class WeatherHelper {
  static AssetGenImage? getWeatherImage(int code) {
    if (code == 0) return Assets.icons.clear;
    if (code > 0 && code < 4) {
      return Assets.icons.cloud;
    }
    if (code == 45 || code == 48) {
      return Assets.icons.fog;
    }
    if (code >= 51 && code <= 67) {
      return Assets.icons.rain;
    }
    if (code >= 71 && code <= 86) {
      return Assets.icons.snow;
    }
    if (code >= 95 && code <= 99) {
      return Assets.icons.storm;
    }
    return null;
  }
}
