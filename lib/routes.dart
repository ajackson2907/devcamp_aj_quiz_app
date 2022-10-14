import 'package:fdc_aj_quiz_app/about/about.dart';
import 'package:fdc_aj_quiz_app/admin/admin.dart';
import 'package:fdc_aj_quiz_app/home/home.dart';
import 'package:fdc_aj_quiz_app/login/login.dart';
import 'package:fdc_aj_quiz_app/login/register.dart';
import 'package:fdc_aj_quiz_app/profile/profile.dart';
import 'package:fdc_aj_quiz_app/topics/topics.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/topics': (context) => const TopicsScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/about': (context) => const AboutScreen(),
  '/profile/admin': (context) => const AdminScreen(),
};
