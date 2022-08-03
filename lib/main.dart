import 'package:flutter/material.dart';
import 'package:mosquito_alraming_app/const/colors.dart';
import 'package:mosquito_alraming_app/screens/home_page.dart';

void main(List<String> args) async {
  runApp(MaterialApp(
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          color: Colors.white,
        ),
        primary: MAIN_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ))),
      home: HomeScreen()));
}
