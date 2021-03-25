import 'package:flutter/material.dart';

//purple Theme
var purpleColor = Colors.purple;
var purpleAccent = Colors.purpleAccent;

// Green Theme
var greenColor = Colors.green;
var greenAccent = Colors.greenAccent;

var purpleTheme = ThemeData(
    primarySwatch: purpleColor,
    accentColor: purpleAccent,
    textTheme: getTextTheme(purpleColor, purpleAccent));

var greenTheme = ThemeData(
    primarySwatch: greenColor,
    accentColor: greenAccent,
    textTheme: getTextTheme(greenColor, greenAccent),
);

TextTheme getTextTheme(Color primaryColor, Color secondaryColor) {
  return TextTheme(
      headline1: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
      headline2: TextStyle(color: Colors.grey),
// For textStyles that emulates the primarySwatch Color
      headline3: TextStyle(
          color: Colors.deepPurple, fontSize: 17, fontWeight: FontWeight.bold),
      headline4: TextStyle(
        color: Colors.white,
      ));
}


