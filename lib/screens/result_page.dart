import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/models/Questuins.dart';
import 'package:quizapp/screens/QuizPage.dart';
import 'package:quizapp/widgets/next_button.dart';

class resultPage extends StatelessWidget {
  const resultPage({
    super.key,
    required this.score,
  });

  final int score;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
           'yoor score is ${(score)}',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w500,
            ),
          ),
          RectangularButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => QuizPage(
                  ),
                ),
              );
            },
            label: "restart",
          )
        ],
      ),
    );
  }
}
