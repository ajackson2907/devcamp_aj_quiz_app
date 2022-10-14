import 'package:fdc_aj_quiz_app/login/login.dart';
import 'package:fdc_aj_quiz_app/services/auth.dart';
import 'package:fdc_aj_quiz_app/shared/error.dart';
import 'package:fdc_aj_quiz_app/shared/loading.dart';
import 'package:fdc_aj_quiz_app/topics/topics.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: ErrorMessage(),
          );
        } else if (snapshot.hasData) {
          return const TopicsScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
