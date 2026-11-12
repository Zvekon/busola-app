import 'package:flutter/material.dart';

class WynikPage extends StatefulWidget {
  final List correct;
  final List chosen;
  const WynikPage({super.key, required this.correct, required this.chosen});

  @override
  State<WynikPage> createState() => _WynikPageState();
}

class _WynikPageState extends State<WynikPage> {
  int correctScore = 0;
  double percentage = 0;


  @override
  void initState() {
    super.initState();

    for(int i = 0; i < widget.chosen.length; i++) {
      if(widget.chosen[i] == widget.correct[i]) {
        setState(() {
          correctScore++;
        });
      }
    }

    setState(() {
      percentage = correctScore/widget.chosen.length * 100;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Zdobyłeś ${percentage.toStringAsFixed(1)}%", style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w500
            ),
            ),
          ),
          Text("$correctScore/${widget.chosen.length} poprawnych odpowiedzi", style: const TextStyle(
              fontSize: 22.0
          ),),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text("Wróć do strony głównej"))
        ],
      ),
    );
  }
}