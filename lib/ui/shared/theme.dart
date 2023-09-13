import 'package:breeze_case/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BreezeTheme {
  /// Returns the theme of the app.
  static ThemeData themeData = ThemeData(
    cardColor: kWhiteColor,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: kDarkBlue,
      onPrimary: kWhiteColor,
      secondary: kDarkBlue,
      onSecondary: kWhiteColor,
      error: kPinkColor,
      onError: kWhiteColor,
      background: kWhiteColor,
      onBackground: kDarkBlue,
      surface: kWhiteColor,
      onSurface: kDarkBlue,
    ),
    primaryColor: kDarkBlue,
    scaffoldBackgroundColor: kWhiteColor,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    iconTheme: const IconThemeData(color: kDarkBlue),
    primaryIconTheme: const IconThemeData(color: kDarkBlue),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.dmSans(
        color: kDarkBlue,
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: GoogleFonts.dmSans(
        color: kDarkBlue,
        fontSize: 28,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: GoogleFonts.dmSans(
        color: kDarkBlue,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: GoogleFonts.dmSans(
        color: kDarkBlue,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: GoogleFonts.dmSans(
        color: kDarkBlue,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.dmSans(
        color: kDarkBlue,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: GoogleFonts.dmSans(
        color: kDarkBlue,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: GoogleFonts.dmSans(
        color: kDarkBlue,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: GoogleFonts.dmSans(
        color: kDarkBlue,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: GoogleFonts.dmSans(
        color: kDarkBlue,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: GoogleFonts.dmSans(
        color: kDarkBlue,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.dmSans(
        color: kDarkBlue,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: kWhiteColor,
      foregroundColor: kDarkBlue,
      elevation: 0,
      iconTheme: IconThemeData(color: kDarkBlue),
      actionsIconTheme: IconThemeData(color: kDarkBlue),
    ),
    cardTheme: const CardTheme(
      color: kWhiteColor,
      shadowColor: kGreyColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    dialogTheme: DialogTheme(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      titleTextStyle: GoogleFonts.dmSans(
        color: kPinkColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      contentTextStyle: GoogleFonts.dmSans(
        color: kDarkBlue,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: kPinkColor,
        textStyle: GoogleFonts.dmSans(
          color: kPinkColor,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  );
}
