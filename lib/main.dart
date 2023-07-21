import 'package:api_dashboard/config/theme/app_theme.dart';
import 'package:api_dashboard/services/weather_api_cliente.dart';
import 'package:api_dashboard/views/additional_information.dart';
import 'package:api_dashboard/views/current_weather.dart';
import 'package:api_dashboard/models/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

IconData getWeatherIcon(double temperature) {
  if (temperature < 10) {
    // Frío
    return Icons.ac_unit;
  } else if (temperature >= 10 && temperature < 20) {
    // Templado
    return Icons.wb_cloudy;
  } else {
    // Cálido
    return Icons.wb_sunny;
  }
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme(selectedColor: 0).theme(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  String locationLatLong = '';

  String lat = '-12.0432';
  String long = '-77.0282';

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Permisos denegados");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Permisos denegados");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Permisos denegados permanentemente");
    }

    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 100);

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();

      setState(() {
        locationLatLong = '$lat ' ' $long';
      });
    });
  }

  Future<void> getData() async {
    data = await client.getCurrentWeatherByLocation(lat, long);
  }

  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF00BCDE),
              Color(0xFFa1f6ff),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  currentWeather(
                    "${data!.temp}",
                    "${data!.cityName}",
                    "${data!.country}",
                  ),
                  Text(
                    locationLatLong,
                    style: const TextStyle(color: Color(0xFF125067)),
                  ),
                  const SizedBox(height: 60),
                  const Text(
                    "Información adicional",
                    style: TextStyle(fontSize: 24, color: Color(0xFF125067)),
                  ),
                  const SizedBox(height: 20),
                  WeatherInfoWidget(
                    windPressure: "${data!.wind}",
                    humidity: "${data!.humidity}",
                    pressure: "${data!.pressure}",
                    temperature: "${data!.feelsLike}",
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _getCurrentLocation().then((value) {
                        lat = '${value.latitude}';
                        long = '${value.longitude}';

                        setState(() {
                          locationLatLong = '$lat ' ' $long';
                        });
                        _liveLocation();
                      });
                    },
                    child: const Text('Actualizar'),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
