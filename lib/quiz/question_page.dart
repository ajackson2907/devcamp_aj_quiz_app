import 'package:fdc_aj_quiz_app/helpers/app_constants.dart';
import 'package:fdc_aj_quiz_app/main.dart';
import 'package:fdc_aj_quiz_app/models/models.dart';
import 'package:fdc_aj_quiz_app/quiz/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuestionPage extends ConsumerWidget {
  final Question question;
  const QuestionPage({super.key, required this.question});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(quizStateNotifier);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(question.text),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: question.options.map((opt) {
              return Container(
                height: 90,
                margin: const EdgeInsets.only(bottom: 10),
                color: Colors.black26,
                child: InkWell(
                  onTap: () {
                    state.selected = opt;
                    _bottomSheet(context, opt, state);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(state.selected == opt ? FontAwesomeIcons.circleCheck : FontAwesomeIcons.circle, size: 30),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: Text(
                              opt.value,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  /// Bottom sheet shown when Question is answered
  _bottomSheet(BuildContext context, Option opt, QuizState state) {
    bool correct = opt.correct;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(correct ? 'Good Job!' : 'Wrong'),
              Text(
                opt.detail,
                style: const TextStyle(fontSize: 18, color: Colors.white54),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: correct ? AppConstants.hexToColor(AppConstants.appPrimaryColorAction) : Colors.red),
                child: Text(
                  correct ? 'Next =>' : 'Try Again',
                  style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (correct) {
                    state.nextPage();
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
