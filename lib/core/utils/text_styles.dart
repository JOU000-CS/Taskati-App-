import 'package:flutter/material.dart';


class TextStyles {
  static TextStyle titleStyle({Color? color, double fontSize = 18.0, FontWeight fontWeight = FontWeight.w600, String fontFamily = 'Poppins'}) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
  }

  static TextStyle bodyStyle({Color? color, double fontSize = 16.0, FontWeight fontWeight = FontWeight.w600, String fontFamily = 'Poppins'}) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
  }

  static TextStyle smallStyle({Color? color, double fontSize = 14.0, FontWeight fontWeight = FontWeight.normal, String fontFamily = 'Poppins'}) {
    return TextStyle(
      fontSize: 14.0,
      color: color,
      fontWeight: FontWeight.normal,
      fontFamily: 'Poppins',
    );
  }
}