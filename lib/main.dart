import 'package:flutter/material.dart';
import 'package:weather_app/ui_pages/city_change_page.dart';
import 'package:weather_app/ui_pages/weather_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Weather App",
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromARGB(255, 164, 124, 181),
                    Color.fromARGB(255, 235, 178, 205)
                  ]),
            ),
            child: //const CityChangePage(),

                const WeatherPage(),
          ),
        ));
  }
}
