// ignore_for_file: file_names, prefer_const_constructors, duplicate_ignore, non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quizapp/screens/result_page.dart';
import 'package:quizapp/widgets/next_button.dart';

import '../models/Questions.dart';
import '../widgets/answer_card.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int? selectedAnswerIndex;
  int questionIndex = Random().nextInt(questions.length);
  int score = 0;
  void pickAnswer(int value) {
    selectedAnswerIndex = value;
    final question = questions[questionIndex];
    if (selectedAnswerIndex == question.correctAnswerIndex) {
      score++;
    }
    setState(() {});
  }

  void goToNextQuestion() {
    if (questionIndex < questions.length - 1) {
      questionIndex++;
      selectedAnswerIndex = null;
    }
    setState(() {
    });
  }
  void goBack() {
    if(questionIndex!=0){
      questionIndex--;
    }
    setState(() {
    });
  }
  void Restart() {
    ( score =0);
  }
  void shuffle(List , [ start = 0, int? end, Random? random]) {
    random ??= Random();
    end ??= questions.length;
    var length = end - start;
    while (length > 1) {
      var pos = random.nextInt(questions.length);
      length--;
      var tmp1 = questions[start + pos];
      questions[start + pos] = questions[start + length];
      questions[start + length] = tmp1;
    }
  }
  @override
  Widget build(BuildContext context) {
    final question = questions[questionIndex];
    bool isLastQuestion = questionIndex == questions.length - 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('your score so far: $score'),
      ),
      // ignore: duplicate_ignore
      body: Padding(
        // ignore: prefer_const_constructors
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              question.question,
              style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),

            ListView.builder(
              padding: EdgeInsets.all(15),
              shrinkWrap: true,
                itemCount: question.options.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: selectedAnswerIndex == null ? () => pickAnswer(index) : null,
                    child: AnswerCard(
                      currentIndex: index,
                      question: question.options[index],
                      isSelected: selectedAnswerIndex == index,
                      selectedAnswerIndex: selectedAnswerIndex,
                      correctAnswerIndex: question.correctAnswerIndex,
                    ),
                  );
                },
              ),

            isLastQuestion
                ? RectangularButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => resultPage(
                      score: score,
                    ),
                  ),
                );
              },
              label: 'Finish',
            ) :
                 RectangularButton(
              onPressed:
              selectedAnswerIndex != null ? goToNextQuestion : null,
              label: 'Next',
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  child: Card(
                    child: Text("back",
                      style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  onPressed: (){
                    goBack();
                    setState(() {
                      if (score !=0 ) {
                        score--;
                      }
                    });
                  },
                ),
                TextButton(
                  child: Card(
                    child: Text('Restart',
                      style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  onPressed: (){
                    setState(() {
                      Restart();
                      questionIndex = Random().nextInt(questions.length);

                    });
                  },
                ),
                TextButton(
                  child: Card(
                    child: Text('shuffle',
                      style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  onPressed: (){
                    setState(() {
                      shuffle(questions);
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}