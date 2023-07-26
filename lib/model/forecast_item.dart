class ForecastItem {
  final DateTime dateTime;
  final double temperature;
  final double temperatureMin;
  final double temperatureMax;
  final String mainWeather;

  ForecastItem({
    required this.dateTime,
    required this.temperature,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.mainWeather,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      dateTime: DateTime.parse(json['dt_txt']),
      temperature: json['main']['temp'],
      temperatureMin: json['main']['temp_min'],
      temperatureMax: json['main']['temp_max'],
      mainWeather: json['weather'][0]['main'],
    );
  }
}
