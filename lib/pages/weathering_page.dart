import 'package:flutter/material.dart';
import 'package:weathering/models/weathering_model.dart';
import 'package:weathering/services/weathering_service.dart';
import 'package:lottie/lottie.dart';

const String apiKey = 'YOUR_API_KEY_HERE';  // Define your API key here

class WeatheringPage extends StatefulWidget {
  const WeatheringPage({super.key});

  @override
  State<WeatheringPage> createState() => _WeatheringPageState();
}

class _WeatheringPageState extends State<WeatheringPage> {
  final WeatherService _weatherService = WeatherService(apiKey);
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloudy.json';
      case 'mist':
        return 'assets/cloudy.json';
      case 'smoke':
        return 'assets/cloudy.json';
      case 'dust':
        return 'assets/snowing.json';
      case 'fog':
        return 'assets/cloudy.json';
      case 'drizzle':
        return 'assets/rainy.json';
      case 'shower rain':
        return 'assets/rainy.json';  
      case 'thunder':
        return 'assets/Thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading city.."),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text('${_weather?.temperature.round()}°C'),

            Text(_weather?.mainCondition ?? "loading description.."),
          ],
        )
      ),
    );
  }
}
