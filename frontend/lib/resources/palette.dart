import 'package:flutter/material.dart';

class Palette {
  static const Color appBarColor = Color(0xFF00AF54);
  static const Color appNameColor = Color(0xFFFFE082);
  static const Color appBarColorLinear = Color(0xFF0EB177);
  static const Color unselectedIconColor = Color(0xFF767676);
  static const Color backgroundColor = Color(0xFFEDEDED);
  static const Color textFieldColor = Color(0xFFFFFFFF);
  static const Color buttonColor = Color(0xFF00af54);
  static const Color buttonColorRed = Colors.red;
  static const Color textColor = Color(0xFF767676);
  static const Color blackColor = Color(0xff19191b);

  static const Color gradientColorStart = Color(0xFF00AF54);
  static const Color gradientColorEnd = Color(0xFF0EB177);
  static const Color separatorColor = Color(0xff272c35);

  static const Gradient fabGradient = LinearGradient(
      colors: [gradientColorStart, gradientColorEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
}
