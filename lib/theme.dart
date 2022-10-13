import 'package:fdc_aj_quiz_app/helpers/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var appTheme = ThemeData(
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color.fromARGB(221, 175, 175, 175),
  ),
  brightness: Brightness.dark,
  primaryColor: AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
  backgroundColor: AppConstants.hexToColor(AppConstants.appBackgroundColor),
  primaryColorLight: AppConstants.hexToColor(AppConstants.appPrimaryColorLight),
  dividerColor: AppConstants.hexToColor(AppConstants.appBackgroundColorGray),
  textTheme: TextTheme(
    caption: TextStyle(
        color: AppConstants.hexToColor(AppConstants.appPrimaryFontColorWhite)),
    bodyText1: const TextStyle(fontSize: 18),
    bodyText2: const TextStyle(fontSize: 16),
    button: const TextStyle(
      letterSpacing: 1.5,
      fontWeight: FontWeight.bold,
    ),
    headline1: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    subtitle1: const TextStyle(
      color: Colors.grey,
    ),
  ),
  buttonTheme: const ButtonThemeData(),
  fontFamily: GoogleFonts.nunito().fontFamily,
);

class ThemeTextStyle {
  static TextStyle loginTextFieldStyle = GoogleFonts.lato(
      textStyle: const TextStyle(
    color: Colors.blueGrey,
  ));
}
