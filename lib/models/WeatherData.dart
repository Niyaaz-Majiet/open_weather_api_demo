import 'package:equatable/equatable.dart';
import 'package:open_weather_api_demo/models/Clouds.dart';
import 'package:open_weather_api_demo/models/Coord.dart';
import 'package:open_weather_api_demo/models/Weather.dart';
import 'package:open_weather_api_demo/models/WeatherMain.dart';
import 'package:open_weather_api_demo/models/WeatherSys.dart';
import 'package:open_weather_api_demo/models/Wind.dart';

class WeatherData extends Equatable {
  final Coord coord;
  final List<Weather> weather;
  final String base;
  final WeatherMain main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final WeatherSys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  const WeatherData(
      {this.coord,
      this.weather,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.dt,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod});

  @override
  List<Object> get props => [
        coord,
        weather,
        base,
        main,
        visibility,
        wind,
        clouds,
        dt,
        sys,
        timezone,
        id,
        name,
        cod
      ];

  static List<Weather> getWeatherList(List<dynamic> json) {
    var weatherList = json;
    List<Weather> weather = [];

    for (int i = 0; i < weatherList.length; i++) {
      var weatherObject = Weather(
          description: weatherList[i]['description'],
          icon: weatherList[i]['icon'],
          id: weatherList[i]['id'],
          main: weatherList[i]['main']);
      weather.add(weatherObject);
    }

    return weather;
  }

  static WeatherData fromJson(dynamic json) {
    return WeatherData(
        coord: Coord(lat: json['lat'], lon: json['lon']),
        weather: getWeatherList(json['weather']),
        base: json['base'],
        main: WeatherMain(
            feels_like: json['main']['feels_like'],
            humidity: json['main']['humidity'],
            pressure: json['main']['pressure'],
            temp: json['main']['temp'],
            temp_max: json['main']['temp_max'],
            temp_min: json['main']['temp_min']),
        visibility: json['visibility'],
        wind: Wind(deg: json['deg'], speed: json['speed']),
        clouds: Clouds(all: json['all']),
        dt: json['dt'],
        sys: WeatherSys(
            id: json['id'],
            country: json['country'],
            sunrise: json['sunrise'],
            sunset: json['sunset'],
            type: json['type']),
        timezone: json['timezone'],
        id: json['id'],
        name: json['name'],
        cod: json['cod']);
  }
}
