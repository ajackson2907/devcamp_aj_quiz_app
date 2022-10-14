import 'package:fdc_aj_quiz_app/main.dart';
import 'package:fdc_aj_quiz_app/models/models.dart';
import 'package:fdc_aj_quiz_app/quiz/congrats_page.dart';
import 'package:fdc_aj_quiz_app/quiz/question_page.dart';
import 'package:fdc_aj_quiz_app/quiz/quiz_start_page.dart';
import 'package:fdc_aj_quiz_app/services/firestore.dart';
import 'package:fdc_aj_quiz_app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key, required this.quizId});
  final String quizId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(quizStateNotifier);
    return FutureBuilder<Quiz>(
      future: FirestoreService().getQuiz(quizId),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return const Loader();
        } else {
          var quiz = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: AnimatedProgressbar(value: state.progress),
              leading: IconButton(
                icon: const Icon(FontAwesomeIcons.xmark),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              controller: state.controller,
              onPageChanged: (int idx) => state.progress = (idx / (quiz.questions.length + 1)),
              itemBuilder: (BuildContext context, int idx) {
                if (idx == 0) {
                  return StartPage(quiz: quiz);
                } else if (idx == quiz.questions.length + 1) {
                  return CongratsPage(quiz: quiz);
                } else {
                  return QuestionPage(question: quiz.questions[idx - 1]);
                }
              },
            ),
          );
        }
      },
    );
  }
}
