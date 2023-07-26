import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/viewmodel/weather_viewmodel.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<WeatherViewModel>(context, listen: false).fetchWeatherData();
  // }

  Icon _getWeatherIcon(String mainWeather) {
    switch (mainWeather) {
      case 'Rain':
        return Icon(Icons.water);
      case 'Clear':
        return Icon(Icons.wb_sunny);
      case 'Clouds':
        return Icon(Icons.cloud);
      default:
        return Icon(Icons.nat);
    }
  }

  IconData _getCloudIcon(String mainWeather) {
    switch (mainWeather) {
      case 'Rain':
        return Icons.water;
      case 'Clear':
        return Icons.cloud_done;
      case 'Clouds':
        return Icons.cloud;
      default:
        return Icons.cloud;
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherViewModel = Provider.of<WeatherViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Current Weather',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(_getCloudIcon(weatherViewModel.mainWeather), size: 64),
                FutureBuilder(
                  future: Provider.of<WeatherViewModel>(context, listen: false)
                      .fetchWeatherData(),
                  builder: (context, snapshot) => Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Location',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        weatherViewModel.location,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Temperature',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        weatherViewModel.temperature,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Humidity',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        weatherViewModel.humidity,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Wind Speed',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        weatherViewModel.windSpeed,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Forecast',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: weatherViewModel.forecast.length > 5
                  ? 5
                  : weatherViewModel.forecast.length,
              itemBuilder: (context, index) {
                print('object');
                final forecastItem = weatherViewModel.forecast[index];
                final weatherIcon = _getWeatherIcon(forecastItem.mainWeather);

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    leading: weatherIcon,
                    title: Text('Day ${index + 1}'),
                    subtitle: Text(
                        '${forecastItem.temperatureMin} - ${forecastItem.temperatureMax}'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
