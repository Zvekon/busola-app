import "dart:async";
import "dart:convert";
import "dart:math";

import "package:busola_app/trening/trening_question.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

class TreningScreen extends StatefulWidget {
  final Map<String, int> tren;
  const TreningScreen({super.key, required this.tren});

  @override
  State<TreningScreen> createState() => _TreningScreenState();
}

class _TreningScreenState extends State<TreningScreen> {
  final PageController _pc = PageController();
  List<Widget> str = [];
  Future<bool> willPop() async {
    bool value = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Czy na pewno chcesz opuścić trening?"),
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
  }

  Future<List<Widget>> readQuestionsFromFile() async {
    Random r = Random();
    List<Widget> st = [];
    int total = 0;
    int qi = 1;

    for (int v in widget.tren.values) {
      total += v;
    }

    for (var e in widget.tren.entries) {
      var json =
          await rootBundle.loadString("lib/assets/questions/${e.key}.json");
      var obj = jsonDecode(json);
      for (int i = 0; i < e.value; i++) {
        var question = obj[r.nextInt(obj.length)];
        obj.remove(question);
        st.add(TreningQuestion(
          question: question["question"],
          answers: [...question["answers"]],
          correctAnswer: question["correctAnswer"],
          total: total,
          questionId: qi,
          onCorrectAnswer: () => Timer(
              const Duration(milliseconds: 500),
                  () => _pc.nextPage(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.linearToEaseOut)),
        ));
        qi++;
      }
    }
    st.shuffle(r);
    return st;
  }

  @override
  void initState() {
    readQuestionsFromFile().then((value) => setState(() => str = value));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
        appBar: AppBar(
            title: const Text("Trening"),
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
        body: PageView(
          controller: _pc,
          scrollDirection: Axis.vertical,
          children: [
            ...str,
            Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("To wszystko!", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24.0)),
                    TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Wróć do strony głównej",))
                  ],
            ))
          ],
        ),
      ),
    );
  }
}
