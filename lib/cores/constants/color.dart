import 'package:flutter/material.dart';

// const Color kcDarkTextColor = Color(0xff121111);
const Color kcPrimaryColor = Color(0xff272727);
const Color kcSecondaryColor = Color(0xFF11A27F);

const Color kcTextColor = Color(0xFF111213);
const Color kcSoftTextColor = Color(0xFF4F5E62);

const Color kcGreyLight = Color(0xffEEEEEE);
const Color kcGrey400 = Color(0xffBDBDBD);
const Color kcGrey600 = Color(0xff757575);
const Color kcGrey800 = Color(0xff424242);
const Color kcGrey200 = Color(0xffEEEEEE);
const Color kcGrey100 = Color(0xffF5F5F5);

const Color kcWhite = Color(0xFFFFFFFF);
const Color kcBackground = Color.fromARGB(255, 255, 255, 255);
const Color kcDarkBackground = Color(0xFF121212);

const Color kcSuccessColor = Color(0xff15DC71);
const Color kcErrorColor = Color(0xffFF0202);

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: kcBackground,
    primaryColor: kcPrimaryColor,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: kcGrey400,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: kcPrimaryColor,
    ),
    colorScheme: const ColorScheme.light(primary: kcPrimaryColor)
        .copyWith(error: kcErrorColor),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: kcPrimaryColor,
    textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.white)),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),

    // textSelectionTheme: const TextSelectionThemeData(
    //   cursorColor: Colors.white,
    // ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: kcGrey600,
      selectionColor: kcGrey600,
      selectionHandleColor: kcGrey600,
    ),
    colorScheme: const ColorScheme.dark(primary: kcPrimaryColor)
        .copyWith(error: kcErrorColor),
  );
}

// Them Checker
extension DarkMode on BuildContext {
  bool get isDarkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }
}
