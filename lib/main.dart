import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view/weather_screen.dart';
import 'package:weather_app/viewmodel/weather_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherViewModel(),
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
      ),
      home: const WeatherScreen(),
    );
  }
}
