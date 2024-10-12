import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_textstyle.dart';

class AppTheme {
  AppTheme._();

  static ThemeData getAppTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.white.withOpacity(0.8),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.teal,
          centerTitle: true,
          elevation: 12,
          titleTextStyle: AppTextStyle.display.medium,
          iconTheme: const IconThemeData(color: AppColors.white)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.teal,
        elevation: 8,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          backgroundColor: AppColors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
