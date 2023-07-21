import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:api_dashboard/models/weather_model.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeatherByLocation(String lat, String long) async {
  
    final endpoint = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=62518a3d6a49676ae23c4c26b81ee74a&units=metric',
    );

    final response = await http.get(endpoint);
    final body = jsonDecode(response.body);
    return Weather.fromJson(body);
  }
}
