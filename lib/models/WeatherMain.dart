import 'package:equatable/equatable.dart';

class WeatherMain extends Equatable {
  final double temp;
  final double feels_like;
  final double temp_min;
  final double temp_max;
  final int pressure;
  final int humidity;

  const WeatherMain(
      {this.temp,
      this.feels_like,
      this.temp_min,
      this.temp_max,
      this.pressure,
      this.humidity});

  @override
  List<Object> get props =>
      [temp, feels_like, temp_min, temp_max, pressure, humidity];
}
