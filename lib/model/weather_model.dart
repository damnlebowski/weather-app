class WeatherModel {
  final String location;
  final String temperature;
  final String humidity;
  final String windSpeed;
  final String mainWeather;

  WeatherModel({
    required this.location,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.mainWeather,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: json['name'],
      temperature: '${json['main']['temp']}°C',
      humidity: '${json['main']['humidity']}%',
      windSpeed: '${json['wind']['speed']} km/h',
      mainWeather: json['weather'][0]['main'],
    );
  }
}
