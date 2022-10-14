import 'package:fdc_aj_quiz_app/firebase_options.dart';
import 'package:fdc_aj_quiz_app/models/models.dart';
import 'package:fdc_aj_quiz_app/quiz/quiz_state.dart';
import 'package:fdc_aj_quiz_app/routes.dart';
import 'package:fdc_aj_quiz_app/services/services.dart';
import 'package:fdc_aj_quiz_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvier = Provider((ref) => AuthService());
final reportStreamProvider = StreamProvider.autoDispose<Report>((ref) {
  return FirestoreService().streamReport();
});
final quizStateNotifier = ChangeNotifierProvider<QuizState>((ref) {
  return QuizState();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(
      child: QuizApp(),
    ),
  );
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
      theme: appTheme,
    );
  }
}
