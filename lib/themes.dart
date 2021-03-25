import 'package:flutter/material.dart';

class Themes {
//purple Theme
  static const _purpleColor = Colors.purple;
  static const _purpleAccent = Colors.purpleAccent;

// Green Theme
  static const _greenColor = Colors.green;
  static const _greenAccent = Colors.greenAccent;

  static final purpleTheme = ThemeData(
      primarySwatch: _purpleColor,
      accentColor: _purpleAccent,
      textTheme: _getTextTheme(_purpleColor, _purpleAccent));

  static final greenTheme = ThemeData(
    primarySwatch: _greenColor,
    accentColor: _greenAccent,
    textTheme: _getTextTheme(_greenColor, _greenAccent),
  );

  static TextTheme _getTextTheme(Color primaryColor, Color accentColor) {
    return TextTheme(
        headline1: TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
        headline2: TextStyle(color: Colors.grey),
// For textStyles that emulates the primarySwatch Color
        headline3: TextStyle(
            color: primaryColor,
            fontSize: 17,
            fontWeight: FontWeight.bold),
        headline4: TextStyle(
          color: Colors.white,
        ));
  }

  static Map<String, ThemeData> getThemes(){
    return {
      "purple": purpleTheme,
      "green": greenTheme,
    };
  }
}
