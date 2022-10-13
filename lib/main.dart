import 'package:fdc_aj_quiz_app/firebase_options.dart';
import 'package:fdc_aj_quiz_app/models/models.dart';
import 'package:fdc_aj_quiz_app/routes.dart';
import 'package:fdc_aj_quiz_app/services/services.dart';
import 'package:fdc_aj_quiz_app/shared/shared.dart';
import 'package:fdc_aj_quiz_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      Provider<AuthService>(create: (_) => AuthService()),
      Provider<Report>(create: (_) => Report()),
    ],
    child: const QuizApp(),
  ));
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: ErrorMessage(
                  message: 'Firebase Init failed: ${snapshot.error}',
                ),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider(
            create: (context) => FirestoreService().streamReport(),
            catchError: (context, error) => Report(),
            initialData: Report(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              routes: appRoutes,
              theme: appTheme,
            ),
          );
        }
        return const MaterialApp(
          home: LoadingScreen(),
        );
      },
    );
  }
}
