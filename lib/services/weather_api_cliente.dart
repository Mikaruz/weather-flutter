import 'dart:convert';

import 'package:api_dashboard/config/constants/enviroment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:api_dashboard/models/weather_model.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeatherByLocation(String lat, String long) async {
    String apiKey = Environment.apiKey;

    final endpoint = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric',
    );

    final response = await http.get(endpoint);
    final body = jsonDecode(response.body);
    return Weather.fromJson(body);
  }
}
