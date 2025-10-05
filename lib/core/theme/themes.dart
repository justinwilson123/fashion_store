import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../injiction_container.dart' as di;

class Themes {
  final ThemeData ligthTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      secondaryContainer: Colors.white,
      surface: Colors.grey.shade200,
      primary: Colors.grey.shade500,
      secondary: const Color.fromARGB(255, 245, 243, 243),
      inversePrimary: Colors.black,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.aBeeZee(
        color: Colors.grey.shade900,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.aBeeZee(
        fontSize: 16,
        color: Colors.grey.shade900,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.aBeeZee(
        color: Colors.grey.shade500,
        fontSize: 10,
      ),
      headlineSmall: GoogleFonts.aBeeZee(
        color: Colors.grey.shade900,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: GoogleFonts.aBeeZee(fontSize: 16, color: Colors.white),
      headlineMedium: GoogleFonts.aBeeZee(
        fontSize: 13,
        color: Colors.grey.shade500,
      ),
      bodyLarge: GoogleFonts.aBeeZee(
        fontSize: 13,
        color: Colors.grey.shade900,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  final ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.black54,
    ),
    colorScheme: ColorScheme.dark(
      secondaryContainer: Colors.grey.shade900,
      surface: Colors.grey.shade900,
      primary: Colors.grey.shade600,
      secondary: Colors.grey.shade800,
      inversePrimary: Colors.white,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.aBeeZee(
        color: Colors.grey.shade100,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.aBeeZee(
        fontSize: 16,
        color: Colors.grey.shade100,
      ),
      displaySmall: GoogleFonts.aBeeZee(
        color: Colors.grey.shade400,
        fontSize: 10,
      ),
      headlineSmall: GoogleFonts.aBeeZee(
        color: Colors.grey.shade100,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: GoogleFonts.aBeeZee(fontSize: 16, color: Colors.black),
      headlineMedium: GoogleFonts.aBeeZee(
        fontSize: 13,
        color: Colors.grey.shade500,
      ),
    ),
  );

  Future<Unit> changeTheme(String themeMode) async {
    final SharedPreferences sharedPreferences = di.sl<SharedPreferences>();

    sharedPreferences.setString("theme", themeMode);
    return await Future.value(unit);
  }

  Future<ThemeData> returnThemeMode() async {
    final SharedPreferences sharedPreferences = di.sl<SharedPreferences>();
    String? theme = sharedPreferences.getString("theme");
    if (theme == null) {
      return Future.value(ligthTheme);
    } else if (theme == "dark") {
      return Future.value(darkTheme);
    } else {
      return Future.value(ligthTheme);
    }
  }

  Future<String> returnThemeName() async {
    final SharedPreferences sharedPreferences = di.sl<SharedPreferences>();
    String? theme = sharedPreferences.getString("theme");
    if (theme == null) {
      return await Future.value("light");
    } else {
      return await Future.value(theme);
    }
  }
}
