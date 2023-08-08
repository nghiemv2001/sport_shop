import 'package:flutter/material.dart';

ThemeData themData = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      foregroundColor: Colors.black45,
      textStyle: const TextStyle(color: Colors.red),
      side: const BorderSide(color: Colors.red, width: 1.7),
    )),
    inputDecorationTheme: InputDecorationTheme(
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            textStyle: const TextStyle(
              fontSize: 18,
            ),
            disabledBackgroundColor: Colors.grey)),
    primarySwatch: Colors.red,
    canvasColor: Colors.red,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarTextStyle: TextStyle(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black)));
OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(
  color: Colors.grey,
));
