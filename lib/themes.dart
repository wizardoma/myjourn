import 'package:flutter/material.dart';

var theme = ThemeData(
  primarySwatch: Colors.deepPurple,
  accentColor: Colors.purpleAccent,
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 16,
      color: Colors.black,

    ),
    headline2: TextStyle(
      color: Colors.grey
    ),
    // For textStyles that emulates the primarySwatch Color
    headline3: TextStyle(
      color: Colors.purple
    ),
    headline4: TextStyle(
      color: Colors.white,
    )
  )
);

