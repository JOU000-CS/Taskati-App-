import 'package:flutter/material.dart';
import 'package:taskati/core/constants/app_fonts.dart';
import 'package:taskati/core/utils/colors.dart';

class AppTheme {
  static get LightTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    fontFamily: AppFonts.poppins,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: Colors.black,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.whiteColor,
      headerBackgroundColor: AppColors.primaryColor,
      headerForegroundColor: Colors.white,
      dayForegroundColor: WidgetStateProperty.all(Colors.black),
      dayBackgroundColor: WidgetStateProperty.all(Colors.transparent),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.whiteColor,
      dialHandColor: AppColors.primaryColor,
      dialBackgroundColor: Colors.grey.shade200,
      entryModeIconColor: AppColors.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
  );

  static get DarkTheme => ThemeData(
    scaffoldBackgroundColor: Colors.black,
    fontFamily: AppFonts.poppins,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.whiteColor,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.grey.shade900,
      headerBackgroundColor: AppColors.primaryColor,
      headerForegroundColor: Colors.white,
      dayForegroundColor: WidgetStateProperty.all(Colors.white),
      dayBackgroundColor: WidgetStateProperty.all(Colors.transparent),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.grey.shade900,
      dialHandColor: AppColors.primaryColor,
      dialBackgroundColor: Colors.grey.shade800,
      entryModeIconColor: AppColors.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
  );
}
