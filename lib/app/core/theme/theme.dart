import 'package:file_sharing/app/core/theme/my_colors.dart';
import 'package:flutter/material.dart';

class Themes {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor:MyColorLight.scaffoldBackgroundColor,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontSize: 18,
        color: MyColorLight.titleMedium,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: MyColorLight.bodyLarge),
      bodyMedium: TextStyle(fontSize: 14, color: MyColorLight.bodyLarge),
      bodySmall: TextStyle(fontSize: 12, color: MyColorLight.bodySmall),
    ),
    cardColor: MyColorLight.card
  );

  static final darkTheme = ThemeData.dark().copyWith();
}
