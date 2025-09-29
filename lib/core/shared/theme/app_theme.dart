import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/colors/colors.dart';
import '../shared_cubits/theme_cubit/theme_cubit.dart';

class AppTheme {
  // Create ThemeData for light mode
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      fontFamily: context.locale.languageCode == 'ar' ? 'Cairo' : 'Roboto',

      brightness: Brightness.light,
      primarySwatch: AppColors.primaryColor,
      primaryColor: AppColors.primarySwatchColor,
      scaffoldBackgroundColor: AppColors.backgroundColor(false),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primarySwatchColor,
        foregroundColor: AppColors.primaryTextColor(false),
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColors.primaryTextColor(false)),
        bodyMedium: TextStyle(color: AppColors.secondaryTextColor(false)),
        titleLarge: TextStyle(color: AppColors.primaryTextColor(false)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.inputBackgroundColor(false),
        hintStyle: TextStyle(color: AppColors.inputHintColor(false)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderColor(false)),
        ),
      ),
      cardTheme: CardThemeData(color: AppColors.surfaceColor(false)),
    );
  }

  // Create ThemeData for dark mode
  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      fontFamily: context.locale.languageCode == 'ar' ? 'Cairo' : 'Roboto',
      brightness: Brightness.dark,
      primarySwatch: AppColors.primaryColor,
      primaryColor: AppColors.primarySwatchColor,
      scaffoldBackgroundColor: AppColors.backgroundColor(true),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primarySwatchColor,
        foregroundColor: AppColors.primaryTextColor(true),
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColors.primaryTextColor(true)),
        bodyMedium: TextStyle(color: AppColors.secondaryTextColor(true)),
        titleLarge: TextStyle(color: AppColors.primaryTextColor(true)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.inputBackgroundColor(true),
        hintStyle: TextStyle(color: AppColors.inputHintColor(true)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderColor(true)),
        ),
      ),
      cardTheme: CardThemeData(color: AppColors.surfaceColor(true)),
    );
  }
}

// Extension to easily access theme-aware colors from anywhere in your app
extension AppThemeExtension on BuildContext {
  bool get isDarkMode => read<ThemeCubit>().isDarkMode;

  Color get primaryTextColor => AppColors.primaryTextColor(isDarkMode);
  Color get secondaryTextColor => AppColors.secondaryTextColor(isDarkMode);
  Color get backgroundColor => AppColors.backgroundColor(isDarkMode);
  Color get surfaceColor => AppColors.surfaceColor(isDarkMode);
  Color get subtitleColor => AppColors.subtitleColor(isDarkMode);
  Color get inputHintColor => AppColors.inputHintColor(isDarkMode);
  Color get inputBackgroundColor => AppColors.inputBackgroundColor(isDarkMode);
  Color get borderColor => AppColors.borderColor(isDarkMode);
  Color get greyColor => AppColors.greyColor(isDarkMode);
  Color get heavyGreyColor => AppColors.heavyGreyColor(isDarkMode);

  // Static colors that don't change
  Color get primaryColor => AppColors.primarySwatchColor;
  Color get secondaryColor => AppColors.secondaryColor;
  Color get activeGreen => AppColors.activeGreen;
  Color get red => AppColors.red;
  Color get redColor => AppColors.redColor;
  Color get green => AppColors.green;
}
