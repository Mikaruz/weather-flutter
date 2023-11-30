import 'package:flutter/material.dart';

Widget currentWeather(String temp, String location, String country) {
  double temperature = double.parse(temp);

  IconData icon = Icons.location_on_sharp;

  if (temperature < 10) {
    // Frío
    icon = Icons.ac_unit;
  } else if (temperature >= 10 && temperature < 20) {
    // Templado
    icon = Icons.wb_cloudy;
  } else {
    // Cálido
    icon = Icons.wb_sunny;
  }

  return Center(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(
        height: 10.0,
      ),
      Icon(
        icon,
        color: Colors.black,
        size: 64.0,
      ),
      const SizedBox(
        height: 10.0,
      ),
      Text(
        '$temp°C',
        style: const TextStyle(fontSize: 46.0, color: Color(0xFF125067)),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Text(
        "$location $country",
        style: const TextStyle(
          fontSize: 18.0,
          color: Color(0xFF125067),
        ),
      )
    ],
  ));
}
