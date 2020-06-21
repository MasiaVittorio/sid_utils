import 'package:flutter/material.dart';

class RightContrast {
  final ThemeData theme;
  final bool fallbackOnTextTheme;
  final bool fallbackOnIconTheme;
  const RightContrast(this.theme, {
    this.fallbackOnIconTheme = false,
    this.fallbackOnTextTheme = false,
  }): assert(!fallbackOnIconTheme || !fallbackOnTextTheme);

  Color get onCanvas {
    final accent = theme.accentColor;
    final primary = theme.primaryColor;

    final accentDark = ThemeData.estimateBrightnessForColor(accent) == Brightness.dark;
    final primaryDark = ThemeData.estimateBrightnessForColor(primary) == Brightness.dark;
    final canvasDark = ThemeData.estimateBrightnessForColor(theme.canvasColor) == Brightness.dark;


    if(primaryDark != canvasDark)
      return primary;
    else if(accentDark != canvasDark)
      return accent;

    if(fallbackOnIconTheme)
      return theme.iconTheme.color;
    if(fallbackOnTextTheme)
      return theme.textTheme.bodyText2.color;

    return canvasDark ? Colors.white : Colors.black;
  }

  Color get onAccent {
    final primary = theme.primaryColor;

    final accentDark = ThemeData.estimateBrightnessForColor(theme.accentColor) == Brightness.dark;
    final primaryDark = ThemeData.estimateBrightnessForColor(primary) == Brightness.dark;


    if(accentDark != primaryDark)
      return primary;

    if(fallbackOnIconTheme)
      return theme.accentIconTheme.color;
    if(fallbackOnTextTheme)
      return theme.accentTextTheme.bodyText2.color;

    return accentDark ? Colors.white : Colors.black;
  }

  Color get onPrimary {
    final accent = theme.accentColor;

    final accentDark = ThemeData.estimateBrightnessForColor(theme.primaryColor) == Brightness.dark;
    final primaryDark = ThemeData.estimateBrightnessForColor(accent) == Brightness.dark;


    if(accentDark != primaryDark)
      return accent;

    if(fallbackOnIconTheme)
      return theme.primaryIconTheme.color;
    if(fallbackOnTextTheme)
      return theme.primaryTextTheme.bodyText2.color;

    return primaryDark ? Colors.white : Colors.black;
  }

  Color onColor(Color color) {
    final accent = theme.accentColor;
    final primary = theme.primaryColor;

    final accentDark = ThemeData.estimateBrightnessForColor(accent) == Brightness.dark;
    final primaryDark = ThemeData.estimateBrightnessForColor(primary) == Brightness.dark;

    final colorDark = ThemeData.estimateBrightnessForColor(color) == Brightness.dark;

    if(primaryDark != colorDark)
      return primary;
    else if(accentDark != colorDark)
      return accent;

    return colorDark ? Colors.white : Colors.black;
  }

}