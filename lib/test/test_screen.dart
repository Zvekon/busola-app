import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:busola_app/test/test_question.dart';
import 'package:busola_app/test/wynik_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final PageController _pc = PageController(initialPage: 0);
  List<Widget> str = [];
  List odp = List.generate(75, (index) => -1);
  List popodp = [];
  int _czas = (90 * 60).round();
  Future readQuestionsFromFile() async {
    int qi = 1;
    List<Widget> st = [];
    List fNs = [
      'budowajachtu',
      "locja",
      "meteorologia",
      "przepisy",
      "ratownictwo",
      "teoriazeglowania"
    ];
    Random r = Random();
    for (final fN in fNs) {
      var json = await rootBundle.loadString("lib/assets/questions/$fN.json");
      var obj = jsonDecode(json);

      int n = 12;

      if (fN == "budowajachtu") {
        n = 15;
      }

      for (int i = 0; i < n; i++) {
        var question = obj[r.nextInt(obj.length)];
        obj.remove(question);
        st.add(TestQuestion(
            question: question['question'],
            answers: [...question["answers"]],
            correctAnswer: question["correctAnswer"],
            questionId: qi,
            sendToParent: (value, index) {
              setState(() => odp[index] = value);
              Timer(
                  const Duration(milliseconds: 500),
                  () => _pc.nextPage(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.linearToEaseOut));
            },
          total: 75,
        ));
        qi++;
        popodp.add(question["correctAnswer"]);
      }
    }
    return st;
  }

  Future<bool> willPop() async {
    if (_czas > 1) {
      bool value = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Czy na pewno chcesz opuścić test?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Nie")),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Tak")),
              ],
            );
          });
      return value;
    } else {
      return true;
    }
  }

  void zakonczTest() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Czy na pewno chcesz zakończyć test?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Tak")),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Nie")),
              ],
            )).then((value) {
      if (value) {
        setState(() {
          _czas = 0;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    readQuestionsFromFile().then((value) {
      setState(() {
        str = value;
      });
    });

    Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _czas--;
      });

      if (_czas < 0) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
        appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Test"),
                _czas > 1
                    ? Text(
                        "${(_czas / 60).floor().toString()}:${_czas % 60 < 10 ? "0" : ""}${(_czas % 60).toString()}")
                    : const Text(""),
              ],
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.4, 0.6],
                  colors: [
                    Color.fromRGBO(236, 104, 27, 1),
                    Color.fromRGBO(242, 137, 21, 1)
                  ],
                ),
              ),
            ),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor),
        body: _czas > 1
            ? PageView(
                controller: _pc,
                scrollDirection: Axis.vertical,
                children: str,
              )
            : WynikPage(correct: popodp, chosen: odp),
        floatingActionButton: _czas > 1
            ? FilledButton(
                onPressed: zakonczTest,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle_outline),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Zakończ test"),
                      )
                    ],
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}
