import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/model/forecast_item.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_api.dart';

class WeatherViewModel extends ChangeNotifier {
  String _location = '';
  String _temperature = '';
  String _humidity = '';
  String _windSpeed = '';
  String _mainWeather = '';

  List<ForecastItem> _forecast = [];

  String get location => _location;
  String get temperature => _temperature;
  String get humidity => _humidity;
  String get windSpeed => _windSpeed;
  List<ForecastItem> get forecast => _forecast;
  String get mainWeather => _mainWeather;

  WeatherModel? _weatherModel;
  WeatherModel? get weatherModel => _weatherModel;

  Future<void> fetchWeatherData() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('User denied location permission');
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double latitude = position.latitude;
    double longitude = position.longitude;
    print(latitude);
    print(longitude);
    try {
      final currentWeatherData =
          await WeatherApi.getCurrentWeather(latitude, longitude);
      final forecastData =
          await WeatherApi.getWeatherForecast(latitude, longitude);

      _parseCurrentWeatherData(currentWeatherData);
      _parseWeatherForecastData(forecastData);

      notifyListeners();
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  void _parseCurrentWeatherData(Map<String, dynamic> data) {
    _location = data['name'];
    _temperature = '${data['main']['temp']}°C';
    _humidity = '${data['main']['humidity']}%';
    _windSpeed = '${data['wind']['speed']} km/h';
    _mainWeather = data['weather'][0]['main'];

    _weatherModel = WeatherModel(
      location: _location,
      temperature: _temperature,
      humidity: _humidity,
      windSpeed: _windSpeed,
      mainWeather: _mainWeather,
    );
  }

  void _parseWeatherForecastData(Map<String, dynamic> data) {
    _forecast = List<ForecastItem>.from(
      data['list'].map((item) => ForecastItem.fromJson(item)),
    );
  }
}
