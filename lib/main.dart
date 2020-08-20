import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_api_demo/blocs/WeatherBloc.dart';
import 'package:open_weather_api_demo/blocs/bloc_states/WeatherState.dart';
import 'package:open_weather_api_demo/repositories/repositories.dart';
import 'package:open_weather_api_demo/screens/home.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_api_demo/services/services.dart';

class BlocDelegateInstance extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  BlocSupervisor.delegate = BlocDelegateInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository = WeatherRepository(
      weatherService: WeatherService(httpClient: http.Client()));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Weather Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<WeatherBloc>(
          create: (BuildContext context) =>
              WeatherBloc(weatherRepository: weatherRepository),
          child: Home(weatherRepository: weatherRepository)),
    );
  }
}
