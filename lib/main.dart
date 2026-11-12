import 'package:busola_app/home/home_screen.dart';
import 'package:busola_app/test/test_screen.dart';
import 'package:busola_app/trening/trening_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, int> tren = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Busola App',
      theme: ThemeData(
        radioTheme: RadioThemeData(fillColor: MaterialStateColor.resolveWith((states) => const Color.fromRGBO(14, 113, 184, 1))),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromRGBO(236, 104, 27, 1)),
          filledButtonTheme: const FilledButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromRGBO(14, 113, 184, 1)))),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedItemColor: Color.fromRGBO(45, 170, 225, 1)),
        sliderTheme: const SliderThemeData(
          thumbColor: Color.fromRGBO(14, 113, 184, 1),
          activeTrackColor: Color.fromRGBO(14, 113, 184, 1),
          inactiveTrackColor: Color.fromRGBO(45, 170, 225, 1),
          activeTickMarkColor: Color.fromRGBO(45, 170, 225, 1),
          inactiveTickMarkColor: Color.fromRGBO(14, 113, 184, 1)
        )
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(sendToParent: (tr) => setState(() => tren = tr)),
        "/test": (context) => const TestScreen(),
        "/trening": (context) => TreningScreen(tren: tren)
      },
    );
  }
}
