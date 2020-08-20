import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherDataEmptyState extends WeatherState {}

class WeatherDataLoadingState extends WeatherState {}

class WeatherDataLoadedState extends WeatherState {
  final weatherData;

  const WeatherDataLoadedState({@required this.weatherData})
      : assert(weatherData != null);

  @override
  List<Object> get props => [weatherData];
}

class WeatherDataErrorState extends WeatherState {}
