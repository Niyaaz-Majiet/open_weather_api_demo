import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_api_demo/blocs/bloc_events/WeatherEvent.dart';
import 'package:open_weather_api_demo/blocs/bloc_states/WeatherState.dart';
import 'package:open_weather_api_demo/models/models.dart';
import 'package:open_weather_api_demo/repositories/repositories.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  WeatherState get initialState => WeatherDataEmptyState();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeatherDataEvent) {
      yield WeatherDataLoadingState();
      try {
        final WeatherData weatherData =
            await weatherRepository.fetchWeatherData(event.cityName);
        yield WeatherDataLoadedState(weatherData: weatherData);
      } catch (_) {
        yield WeatherDataErrorState();
      }
    }
  }
}
