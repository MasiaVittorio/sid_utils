import 'package:flutter/material.dart';

extension FontWeightSidIncrement on FontWeight {

  static const incrementMap = {
    FontWeight.w100: FontWeight.w200,
    FontWeight.w200: FontWeight.w300,
    FontWeight.w300: FontWeight.w400,
    FontWeight.w400: FontWeight.w500,
    FontWeight.w500: FontWeight.w600,
    FontWeight.w600: FontWeight.w700,
    FontWeight.w700: FontWeight.w800,
    FontWeight.w800: FontWeight.w900,
    FontWeight.w900: FontWeight.w900,
  };

  FontWeight get increment => incrementMap[this];

  static const decrementMap = {
    FontWeight.w100: FontWeight.w100,
    FontWeight.w200: FontWeight.w100,
    FontWeight.w300: FontWeight.w200,
    FontWeight.w400: FontWeight.w300,
    FontWeight.w500: FontWeight.w400,
    FontWeight.w600: FontWeight.w500,
    FontWeight.w700: FontWeight.w600,
    FontWeight.w800: FontWeight.w700,
    FontWeight.w900: FontWeight.w800,
  };

  FontWeight get decrement => decrementMap[this];

}
