import 'package:busola_app/ui/rozpocznij_button.dart';
import 'package:busola_app/ui/trening_input.dart';
import 'package:flutter/material.dart';

class TreningPage extends StatefulWidget {
  final void Function(dynamic tr) sendToParent;
  const TreningPage({super.key, required this.sendToParent});

  @override
  State<TreningPage> createState() => _TreningPageState();
}

class _TreningPageState extends State<TreningPage> {
  Map<String, int> tren = {};

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TreningInput(
              title: "Ratownictwo",
              onChanged: (double value) {
                setState(() {
                  tren.addAll({"ratownictwo": value.round()});
                  widget.sendToParent(tren);
                });
              },

            ),
            TreningInput(
              title: "Budowa jachtu",
              onChanged: (double value) {
                setState(() {
                  tren.addAll({"budowajachtu": value.round()});
                  widget.sendToParent(tren);
                });
              },
            ),
            TreningInput(
              title: "Teoria żeglowania",
              onChanged: (double value) {
                setState(() {
                  tren.addAll({"teoriazeglowania": value.round()});
                  widget.sendToParent(tren);
                });
              },
            ),
            TreningInput(
              title: "Locja",
              onChanged: (double value) {
                setState(() {
                  tren.addAll({"locja": value.round()});
                  widget.sendToParent(tren);
                });
              },
            ),
            TreningInput(
              title: "Przepisy śródlądowe",
              onChanged: (double value) {
                setState(() {
                  tren.addAll({"przepisy": value.round()});
                  widget.sendToParent(tren);
                });
              },
            ),
            TreningInput(
              title: "Meteorologia",
              onChanged: (double value) {
                setState(() {
                  tren.addAll({"meteorologia": value.round()});
                  widget.sendToParent(tren);
                });
              },
            ),
            RozpocznijButton(title: "Rozpocznij trening", onPressed: () => Navigator.of(context).pushNamed("/trening"),)
          ],
        ));
  }
}