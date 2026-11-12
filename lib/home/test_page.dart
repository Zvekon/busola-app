import 'package:busola_app/ui/rozpocznij_button.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Odpowiedz na 75 pytań",
              style: TextStyle(fontSize: 22.0)),
          const Text("w czasie 90 minut", style: TextStyle(fontSize: 22.0)),
          RozpocznijButton(title: "Rozpocznij test", onPressed: () => Navigator.of(context).pushNamed("/test"))
        ],
      ),
    );
  }
}