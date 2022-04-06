import 'package:flutter/material.dart';

import 'color_palette.dart';
class AppStyles{
  static TextStyle? robortoDarkGrayH1 = const TextStyle(
    fontFamily: AppFonts.Roboto,
    color: Palette.textColor,
    fontSize: 24,
    fontWeight: FontWeight.w700
  );
  static TextStyle? robortoDarkGrayB2 = const TextStyle(
      fontFamily: AppFonts.Roboto,
      color: Palette.textColor,
      fontSize: 14,
      fontWeight: FontWeight.w400
  );
  static TextStyle? robortoDarkGrayB1 = const TextStyle(
      fontFamily: AppFonts.Roboto,
      color: Palette.textColor,
      fontSize: 18,
      fontWeight: FontWeight.w400
  );
  static TextStyle? robortoDarkGrayH3 = const TextStyle(
      fontFamily: AppFonts.Roboto,
      color: Palette.textColor,
      fontSize: 12,
      fontWeight: FontWeight.w600
  );

}

class AppFonts{
  static const Roboto = "Roboto";
}