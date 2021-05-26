import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  static const Color authBackGroundColor = Colors.brown;

  //purple Theme
  static const _purpleColor = Colors.purple;
  static const _purpleAccent = Colors.purpleAccent;

  // Green Theme
  static const _greenColor = Colors.green;
  static const _greenAccent = Colors.greenAccent;

  // Red Theme
  static const _redColor = Colors.red;
  static const _redAccent = Colors.pinkAccent;

  // DarkTheme
  static const MaterialColor primaryBlack = MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(_blackPrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  static const int _blackPrimaryValue = 0xFF000000;
  static const MaterialColor primaryWhite = MaterialColor(
    _whitePrimaryValue,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(_whitePrimaryValue),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );
  static const int _whitePrimaryValue = 0xFFFFFFFF;

  static final darkTheme = _getThemeData(primaryBlack, _greenColor, true);

  static final purpleTheme = _getThemeData(_purpleColor, _purpleAccent);

  static final greenTheme = _getThemeData(_greenColor, _greenAccent);

  static final redTheme = _getThemeData(_redColor, _redAccent);

  static ThemeData _getThemeData(primaryColor, accentColor,
      [bool isDarkTheme = false]) {
    return ThemeData(
      primarySwatch: primaryColor,
      primaryColor: primaryColor,
      popupMenuTheme: PopupMenuThemeData(
          elevation: 1,
          color: Colors.white,
          textStyle: TextStyle(
            color: Colors.black87,
          )),
      appBarTheme: AppBarTheme(
        color: isDarkTheme ? Colors.black38 : primaryColor,
        brightness: Brightness.light,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: (primaryColor as MaterialColor).withOpacity(0.4),
            statusBarIconBrightness: Brightness.light),
      ),
      scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,
      cardColor: isDarkTheme ? Colors.black : Colors.white,
      accentColor: accentColor,
      dividerColor: isDarkTheme ? Colors.white : Colors.grey.shade200,
      backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      textTheme: TextTheme(
        bodyText1: TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
        headline1: TextStyle(
            fontSize: 16,
            color: isDarkTheme ? Colors.white : Colors.black87.withOpacity(0.7),
            fontWeight: FontWeight.w400),
        headline2: TextStyle(color: Colors.grey),
// For textStyles that emulates the primarySwatch Color
        headline3: TextStyle(
            color: isDarkTheme ? Colors.white : primaryColor,
            fontSize: 17,
            fontWeight: FontWeight.bold),
        headline4: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  static Map<String, ThemeData> getThemes() {
    return {
      "purple": purpleTheme,
      "green": greenTheme,
      "red": redTheme,
      "dark": darkTheme,
    };
  }
}
