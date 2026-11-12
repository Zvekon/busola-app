import 'package:flutter/material.dart';

class TreningQuestion extends StatefulWidget {
  final String question;
  final List<String> answers;
  final int correctAnswer;
  final int questionId;
  final int total;
  final void Function() onCorrectAnswer;

  const TreningQuestion({
    super.key,
    this.question = "Czy?",
    this.answers = const ["Tak, ale nie wiem, w sumie", "Nie"],
    this.correctAnswer = 0,
    this.questionId = 1,
    required this.total, required this.onCorrectAnswer,
  }) : assert(correctAnswer >= 0 && correctAnswer < answers.length);

  @override
  State<TreningQuestion> createState() => _TreningQuestionState();
}

class _TreningQuestionState extends State<TreningQuestion>
    with AutomaticKeepAliveClientMixin {
  int? selectedAnswer = -1;

  void answerSelected(int? value) {
    setState(() {
      selectedAnswer = value;
    });
    if (value == widget.correctAnswer) {
      widget.onCorrectAnswer();
    }
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
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Text(
                widget.question,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            ...widget.answers.asMap().entries.map((e) {
              int index = e.key;
              String answer = e.value;

              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  children: [
                    selectedAnswer == index
                        ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: (index == widget.correctAnswer
                              ? const Icon(Icons.check_circle,
                                  color: Colors.green)
                              : const Icon(Icons.cancel, color: Colors.red)),
                        )
                        : Radio(
                            value: index,
                            groupValue: selectedAnswer,
                            onChanged: answerSelected),
                    Expanded(
                        child: Text(
                      answer,
                      softWrap: true,
                    )),
                  ],
                ),
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
