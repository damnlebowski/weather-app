import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/utils/config.dart';

class WeatherApi {
  static Future<Map<String, dynamic>> getCurrentWeather(
      double latitude, double longitude) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to fetch current weather data: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> getWeatherForecast(
      double latitude, double longitude) async {
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to fetch weather forecast data: ${response.statusCode}');
    }
  }
}
