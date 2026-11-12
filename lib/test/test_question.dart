import 'package:flutter/material.dart';

class TestQuestion extends StatefulWidget {
  final String question;
  final List<String> answers;
  final int correctAnswer;
  final int questionId;
  final Function? sendToParent;
  final int total;

  const TestQuestion(
      {super.key,
      this.question = "Czy?",
      this.answers = const ["Tak, ale nie wiem, w sumie", "Nie"],
      this.correctAnswer = 0,
      this.questionId = 1,
      this.sendToParent, required this.total,
      }
      ): assert(correctAnswer >= 0 && correctAnswer < answers.length);

  @override
  State<TestQuestion> createState() => _TestQuestionState();
}

class _TestQuestionState extends State<TestQuestion> with AutomaticKeepAliveClientMixin{
  int? selectedAnswer = -1;

  void changeSelectedAnswer(int? value) {
    setState(() {
      selectedAnswer = value;
    });
    widget.sendToParent!(selectedAnswer, widget.questionId - 1);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Text("${widget.questionId}/${widget.total} ${widget.question}",
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)
                , textAlign: TextAlign.center,
      ),
            ),
            ...widget.answers.asMap().entries.map((e) {
              int index = e.key;
              String answer = e.value;

              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  children: [
                  Radio(value: index, groupValue: selectedAnswer, onChanged: changeSelectedAnswer),
                  Expanded(child: Text(answer, softWrap: true,)),
      ],),
              );
            }).toList()
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
