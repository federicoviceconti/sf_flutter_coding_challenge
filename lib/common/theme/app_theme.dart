import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static final lightTheme = ThemeData.light();

  static final darkTheme = ThemeData.dark();

  static var themeMode = ThemeMode.system;

  static final theme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColor.primaryColor,
      backgroundColor: AppColor.backgroundColor,
  );
}