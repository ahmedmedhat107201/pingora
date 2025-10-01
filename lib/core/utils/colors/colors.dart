import 'package:flutter/material.dart';

class AppColors {
  // Base colors that don't change between themes
  static const Color primarySwatchColor = Color(0xffCAB76A);
  static const Color secondaryColor = Color(0xff1A5632);
  static const Color activeGreen = Color(0xff55CC4B);
  static const Color red = Color(0xffD80000);
  static const Color redColor = Color(0xffC32B43);
  static const Color green = Color(0xff00CF79);

  static const Color buttonColor = primarySwatchColor;

  // Light theme colors
  static const Color lightBackground = Color(0xffffffff);
  static const Color lightSurface = Color(0xffF4F6F9);
  static const Color lightPrimaryText = Color(0xff000000);
  static const Color lightSecondaryText = Color(0xff637381);
  static const Color lightSubtitle = Color(0xffB0AEAE);
  static const Color lightInputHint = Color(0xffD6D6D6);
  static const Color lightInputBackground = Color(0xffE7E9E8);
  static const Color lightBorder = Color(0xffD9DBE1);
  static const Color lightGrey = Color(0xff94A3B8);
  static const Color lightHeavyGrey = Color(0xff7E7E7E);

  // Dark theme colors
  static const Color darkBackground = Color(0xff121212);
  static const Color darkSurface = Color(0xff1E1E1E);
  static const Color darkPrimaryText = Color(0xffffffff);
  static const Color darkSecondaryText = Color(0xffB3B3B3);
  static const Color darkSubtitle = Color(0xff8A8A8A);
  static const Color darkInputHint = Color(0xff666666);
  static const Color darkInputBackground = Color(0xff2A2A2A);
  static const Color darkBorder = Color(0xff404040);
  static const Color darkGrey = Color(0xff666666);
  static const Color darkHeavyGrey = Color(0xff999999);

  // Theme-aware color getters
  static Color backgroundColor(bool isDark) =>
      isDark ? darkBackground : lightBackground;

  static Color surfaceColor(bool isDark) => isDark ? darkSurface : lightSurface;

  static Color primaryTextColor(bool isDark) =>
      isDark ? darkPrimaryText : lightPrimaryText;

  static Color secondaryTextColor(bool isDark) =>
      isDark ? darkSecondaryText : lightSecondaryText;

  static Color defaultTextColor(bool isDark) =>
      isDark ? Colors.black : Colors.white;

  static Color subtitleColor(bool isDark) =>
      isDark ? darkSubtitle : lightSubtitle;

  static Color inputHintColor(bool isDark) =>
      isDark ? darkInputHint : lightInputHint;

  static Color inputBackgroundColor(bool isDark) =>
      isDark ? darkInputBackground : lightInputBackground;

  static Color borderColor(bool isDark) => isDark ? darkBorder : lightBorder;

  static Color greyColor(bool isDark) => isDark ? darkGrey : lightGrey;

  static Color heavyGreyColor(bool isDark) =>
      isDark ? darkHeavyGrey : lightHeavyGrey;

  // Legacy colors for backward compatibility (will be removed gradually)
  static const Color grey = Color(0xff8E8E93);
  static const Color greyIN = Color(0xffD9DBE1);
  static const Color greyInput = Color(0xffE7E9E8);
  static const Color black = Color(0xff000000);
  static const Color golden = Color(0xffF4F6F9);
  static const Color txt = Color(0xff637381);
  static const Color alter = Color(0xff33312C);

  static MaterialColor primaryColor =
      const MaterialColor(0xFFCAB76A, <int, Color>{
        50: Color(0x1ACAB76A),
        100: Color(0x33CAB76A),
        200: Color(0x4DCAB76A),
        300: Color(0x66CAB76A),
        400: Color(0x80CAB76A),
        500: Color(0x99CAB76A),
        600: Color(0xB3CAB76A),
        700: Color(0xCCCAB76A),
        800: Color(0xE6CAB76A),
        900: Color(0xFFCAB76A),
      });
}
