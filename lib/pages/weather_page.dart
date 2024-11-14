import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/service/weather_service.dart';
import 'package:weatherapp/widget_common/my_text_field.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //api key
  final _weatherService = WeatherService('0659c727267294ad5b662101c138d6ec');
  Weather? _weather;
  final weatherController = TextEditingController();
  //fetch weather
  _fetchWeather(String cityName) async {

    try {

      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });

      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });

      Navigator.of(context).pop();

    } catch (e) {
      Fluttertoast.showToast(
          msg: "City not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  String getWeatherCondition(String? mainCondition) {
    if(mainCondition == null) return 'assets/sun.png';

    switch(mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.png';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.png';
      case 'thunderstorm':
        return 'assets/thunder.png';
      case 'clear':
        return 'assets/sun.png';
      default:
        return 'assets/sun.png';
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _fetchWeather('ho chi minh');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
        child: Column(
            children: [
              const SizedBox(height: 20),

              MyTextField(
                hintText: 'Enter a city',
                controller: weatherController,
                onSubmitted: (value) {
                  _fetchWeather(value);
                },
              ),

              const SizedBox(height: 60),
              Text(
                _weather?.cityName ?? "loading city",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 60),

              Image.asset(getWeatherCondition(_weather?.mainCondition ?? ""),
                height: 200,
                width: 1000,
              ),

              const SizedBox(height: 20),

              Text(
                '${_weather?.temperature.round()}°C',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300
                ),
              ),

              const SizedBox(height: 40),

              Text(
                _weather?.mainCondition ?? "",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500
                ),
              ),

            ],
          ),
      ),
    );
  }
}
