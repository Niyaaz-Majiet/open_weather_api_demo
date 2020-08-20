import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_api_demo/models/models.dart';
import 'package:meta/meta.dart';

class WeatherService {
  final String _baseUrl =
      "https://api.openweathermap.org/data/2.5/weather";
  final http.Client httpClient;

  WeatherService({@required this.httpClient}) : assert(httpClient != null);

  Future<WeatherData> fetchWeatherData(String cityName) async {
    final url = "$_baseUrl?q=$cityName&appid=5c1ca109c8a2be44a6d00021ec27454e";

    final response = await this.httpClient.get(url);
    if (response.statusCode != 200) {
      throw new Exception("Error Retrieving Weather Data");
    }

    final json = jsonDecode(response.body);
    return WeatherData.fromJson(json);
  }
}
