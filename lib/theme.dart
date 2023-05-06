// import 'dart:ui';
import 'package:flutter/material.dart';

class ChatTheme {
  static ThemeData chatTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF616161),
      foregroundColor: Color(0xFF03A9F4),
      titleTextStyle: TextStyle(
        color: Color(0xFFF5F5F5),
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      ),
    ),

    canvasColor: const Color(0xFFFFFFF),
    cardColor: const Color(0xFF616161),
    dialogBackgroundColor: const Color(0xFF616161),
    disabledColor: const Color(0xFFBDBDBD),
    dividerColor: const Color(0xFFBDBDBD),
    focusColor: const Color(0xFFF5F5F5),
    highlightColor: const Color(0xFFF5F5F5),
    hintColor: const Color(0xFF03A9F4),
    // hoverColor: const Color(0xFFF5F5F5),
    indicatorColor: const Color(0xFF03A9F4),
    primaryColor: const Color(0xFF9E9E9E),
    primaryColorDark: const Color(0xFF616161),
    primaryColorLight: const Color(0xFFF5F5F5),
    scaffoldBackgroundColor: const Color(0xFF9E9E9E),
    secondaryHeaderColor: const Color(0xFF03A9F4),
    shadowColor: const Color(0xFF616161),
    splashColor: const Color(0xFF616161),
    unselectedWidgetColor: const Color(0xFF616161),

    // fontFamily: "Raleway",
    textTheme: const TextTheme(
      displayLarge: TextStyle(
      fontSize: 12.0,
    ),
    displayMedium: TextStyle(
      fontSize: 12.0,
    ),
    displaySmall: TextStyle(
      fontSize: 12.0,
    ),
    headlineLarge: TextStyle(
      fontSize: 12.0,
    ),
    headlineMedium: TextStyle(
      fontSize: 12.0,
    ),
    headlineSmall: TextStyle(
      fontSize: 12.0,
    ),
    titleLarge: TextStyle(
      fontSize: 18.0,
    ),
    titleMedium: TextStyle(
      fontSize: 16.0,
    ),
    titleSmall: TextStyle(
      fontSize: 14.0, 
    ),
    bodyLarge: TextStyle(
      fontSize: 16.0, 
      // fontStyle: FontStyle.italic,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0, 
    ),
    bodySmall: TextStyle(
      fontSize: 14.0, 
    ),
    labelLarge: TextStyle(
      fontSize: 14.0, 
    ),
    labelMedium: TextStyle(
      fontSize: 14.0, 
    ),
    labelSmall: TextStyle(
      fontSize: 14.0, 
      // fontFamily: 'Hind',
    ),
    ), 
  );
}


// const TextStyle({
//     this.inherit = true,
//     this.color,
//     this.backgroundColor,
//     this.fontSize,
//     this.fontWeight,
//     this.fontStyle,
//     this.letterSpacing,
//     this.wordSpacing,
//     this.textBaseline,
//     this.height,
//     this.leadingDistribution,
//     this.locale,
//     this.foreground,
//     this.background,
//     this.shadows,
//     this.fontFeatures,
//     this.fontVariations,
//     this.decoration,
//     this.decorationColor,
//     this.decorationStyle,
//     this.decorationThickness,
//     this.debugLabel,
//     String? fontFamily,
//     List<String>? fontFamilyFallback,
//     String? package,
//     this.overflow,
//   }