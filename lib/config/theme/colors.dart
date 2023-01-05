import 'package:flutter/material.dart';

class AppColors {
  static const Color mainColor = Color(0xff0d6efd);
  static const Color greenColor = Color(0xff17832e);
  static const Color secondaryColor = Color(0xffFF1813);
  static const Color backgroundColor = Colors.white;
  // Color(0xffeff4f5);
  static const Color textFieldFillColor = Color(0xffEBEBEB);
  static const Color greyColor = Color(0xffD2D2D2);
  static const Color greyColor2 = Color(0xffB5B3B3);
  static const Color blueColor = Color(0xff1400FF);
  static const Color redColor = Colors.red;
  static const Color yellowColor = Color(0xffDFB41A);
  static const Color dialogNegativeColor = Color(0xffFC717F);
  static const Color dialogPositiveColor = Color(0xff1CC7A4);
  static const Color borderColor = greyColor2;
  static const Color dividerColor = greyColor2;
  static const Color approvedColor = Color(0xff17832e);
  static Color rejectedColor = Colors.red[800]!;
  static const Color terminalHighlightColor = Colors.yellow;
  static const Color focusedTextFieldColor = Colors.orange;

  static final MaterialColor mainMaterialColor = MaterialColor(mainColor.value, const {
    50: mainColor,
    100: mainColor,
    200: mainColor,
    300: mainColor,
    400: mainColor,
    500: mainColor,
    600: mainColor,
    700: mainColor,
    800: mainColor,
    900: mainColor,
  });
  static const gradientColors = <Color>[mainColor, secondaryColor];

  static const buttonGradient = defaultGradient;

  static const defaultGradient = LinearGradient(colors: gradientColors, end: Alignment(-1.5, 0), begin: Alignment(1.5, 0));
  static const iconGradient = LinearGradient(
    colors: gradientColors,
    end: Alignment(-1.5, 0.0),
    begin: Alignment(
      8.0,
      0.0,
    ),
  );
}
