import 'package:flutter/material.dart';
import 'package:weather_app/ui_pages/weather_page.dart';
import 'package:weather_app/ui_pages/welcome_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromARGB(255, 59, 240, 247),
                      Color.fromARGB(255, 12, 129, 224)
                    ]),
              ),
              child: const WeatherPage(),
            ),
          ),
        ));
  }
}
