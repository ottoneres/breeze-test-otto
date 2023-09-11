import 'package:breeze_case/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BreezeTheme {
  /// Returns the theme of the app.
  static ThemeData themeData = ThemeData(
    primaryColor: kDarkBlue,
    colorScheme: const ColorScheme(
      surface: kWhiteColor,
      background: kWhiteColor,
      brightness: Brightness.light,
      error: kPinkColor,
      onBackground: kDarkBlue,
      onError: kWhiteColor,
      onPrimary: kWhiteColor,
      onSecondary: kWhiteColor,
      onSurface: kDarkBlue,
      primary: kDarkBlue,
      secondary: kDarkBlue,
    ),
    iconTheme: const IconThemeData(color: kDarkBlue),
    primaryIconTheme: const IconThemeData(color: kDarkBlue),
    appBarTheme: const AppBarTheme(
      backgroundColor: kWhiteColor,
      foregroundColor: kDarkBlue,
      actionsIconTheme: IconThemeData(color: kDarkBlue),
      elevation: 0,
      iconTheme: IconThemeData(color: kDarkBlue),
    ),
    scaffoldBackgroundColor: kWhiteColor,
    cardTheme: CardTheme(
      color: kWhiteColor,
      elevation: 0,
      shadowColor: kGreyColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.dmSans(
          fontSize: 30, fontWeight: FontWeight.w500, color: kDarkBlue),
      headlineMedium: GoogleFonts.dmSans(
          fontSize: 28, fontWeight: FontWeight.w500, color: kDarkBlue),
      headlineSmall: GoogleFonts.dmSans(
          fontSize: 24, fontWeight: FontWeight.w500, color: kDarkBlue),
      titleLarge: GoogleFonts.dmSans(
          fontSize: 22, fontWeight: FontWeight.w500, color: kDarkBlue),
      titleMedium: GoogleFonts.dmSans(
          fontSize: 20, fontWeight: FontWeight.w500, color: kDarkBlue),
      titleSmall: GoogleFonts.dmSans(
          fontSize: 18, fontWeight: FontWeight.w500, color: kDarkBlue),
      bodyLarge: GoogleFonts.dmSans(
          fontSize: 16, fontWeight: FontWeight.w500, color: kDarkBlue),
      bodyMedium: GoogleFonts.dmSans(
          fontSize: 14, fontWeight: FontWeight.w500, color: kDarkBlue),
      bodySmall: GoogleFonts.dmSans(
          fontSize: 12, fontWeight: FontWeight.w500, color: kDarkBlue),
      labelLarge: GoogleFonts.dmSans(
          fontSize: 16, fontWeight: FontWeight.w500, color: kDarkBlue),
      labelMedium: GoogleFonts.dmSans(
          fontSize: 14, fontWeight: FontWeight.w500, color: kDarkBlue),
      labelSmall: GoogleFonts.dmSans(
          fontSize: 11, fontWeight: FontWeight.w500, color: kDarkBlue),
    ),
    cardColor: kWhiteColor,
    dialogTheme: DialogTheme(
        titleTextStyle: GoogleFonts.dmSans(
            fontSize: 20, fontWeight: FontWeight.w700, color: kPinkColor),
        contentTextStyle: GoogleFonts.dmSans(
            fontSize: 16, fontWeight: FontWeight.w400, color: kDarkBlue),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: kPinkColor,
        textStyle: GoogleFonts.dmSans(
            fontSize: 16, fontWeight: FontWeight.w700, color: kPinkColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    fontFamily: GoogleFonts.dmSans().fontFamily,
  );
}
