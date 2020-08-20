import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeatherDataEvent extends WeatherEvent {
  final String cityName;

  const FetchWeatherDataEvent({@required this.cityName})
      : assert(cityName != null);

  @override
  List<Object> get props => [];
}
