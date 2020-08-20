import 'package:flutter/cupertino.dart';
import 'package:open_weather_api_demo/models/models.dart';
import 'package:open_weather_api_demo/services/weatherService.dart';

class WeatherRepository {
  final WeatherService weatherService;

  WeatherRepository({@required this.weatherService})
      : assert(weatherService != null);

  Future<WeatherData> fetchWeatherData(String cityName){
    return weatherService.fetchWeatherData(cityName);
  }
}
