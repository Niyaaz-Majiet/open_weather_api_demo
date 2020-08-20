import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_api_demo/blocs/WeatherBloc.dart';
import 'package:open_weather_api_demo/blocs/bloc_events/WeatherEvent.dart';
import 'package:open_weather_api_demo/blocs/bloc_states/WeatherState.dart';
import 'package:open_weather_api_demo/models/models.dart';
import 'package:open_weather_api_demo/repositories/repositories.dart';

class Home extends StatelessWidget {
  final WeatherRepository weatherRepository;

  Home({@required this.weatherRepository}) : assert(weatherRepository != null);

  @override
  Widget build(BuildContext context) {
    String cityName = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Open Weather'),
      ),
      body: Builder(builder: (BuildContext context) {
        return Center(
          child: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (cityInput) {
                  cityName = cityInput;
                },
                decoration: InputDecoration(labelText: 'Enter City Name'),
              ),
              FlatButton(
                onPressed: () {
                  if (cityName.length > 0) {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(FetchWeatherDataEvent(cityName: cityName));
                  } else {
                    displaySnackBar('No City Name Present', context);
                  }
                  cityName = '';
                  FocusScope.of(context).unfocus();
                },
                color: Colors.amber,
                child: Text(
                  "Search",
                ),
              ),
              Expanded(
                child: Center(
                  child: BlocListener<WeatherBloc, WeatherState>(
                    listener: (_, state) {
                      if (state is WeatherDataErrorState) {
                        displaySnackBar("City Not Found", context);
                      }
                    },
                    child: BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (_, state) {
                        if (state is WeatherDataEmptyState) {
                          return _noDataForm('Enter City Name And search ...');
                        } else if (state is WeatherDataErrorState) {
                          return _noDataForm(
                              'An Error Occurred. Please Try Again Later ...');
                        } else if (state is WeatherDataLoadedState) {
                          return _weatherLoadedForm(state.weatherData);
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _noDataForm(String message) => Center(
        child: Text(message),
      );

  Widget _weatherLoadedForm(WeatherData weather) => Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Image.network(
                'http://openweathermap.org/img/wn/${weather.weather[0].icon}@2x.png',
                height: 200.0,
                width: 200.0,
              ),
              SizedBox(height: 10),
              Text(weather.weather[0].main),
              SizedBox(height: 10),
              Text(weather.weather[0].description),
              SizedBox(height: 10),
              Text((weather.main.temp - 273).toStringAsFixed(2)),
            ],
          ),
        ),
      );

  displaySnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
