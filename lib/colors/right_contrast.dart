import 'package:flutter/material.dart';
import 'themes_and_colors.dart';

class RightContrast {

  final ThemeData theme;
  final bool fallbackOnTextTheme;
  final bool fallbackOnIconTheme;

  const RightContrast(this.theme, {
    this.fallbackOnIconTheme = false,
    this.fallbackOnTextTheme = false,
  }): assert(!(fallbackOnIconTheme && fallbackOnTextTheme));

  Color get onCanvas {
    final Color accent = theme.accentColor;
    final Color primary = theme.primaryColor;
    final Color canvas = theme.canvasColor;



    if(primary.legibleOn(canvas))
      return primary;
    else if(accent.legibleOn(canvas))
      return accent;

    if(fallbackOnIconTheme){
      Color? res = theme.iconTheme.color;
      if(res != null) return res;
    }
      
    if(fallbackOnTextTheme){
      Color? res = theme.textTheme.bodyText2?.color;
      if(res != null) return res;
    }

    return canvas.contrast;
  }

  Color get onAccent {
    final Color primary = theme.primaryColor;
    final Color accent = theme.accentColor;


    if(accent.legibleOn(primary))
      return primary;

    if(fallbackOnIconTheme){
      final Color? res = theme.accentIconTheme.color;
      if(res != null) return res;
    }
    if(fallbackOnTextTheme){
      final Color? res = theme.accentTextTheme.bodyText2?.color;
      if(res != null) return res;
    }

    return accent.contrast;
  }

  Color get onPrimary {
    final Color accent = theme.accentColor;
    final Color primary = theme.primaryColor;


    if(accent.legibleOn(primary))
      return accent;

    if(fallbackOnIconTheme){
      final Color? res = theme.primaryIconTheme.color;
      if(res!=null) return res;
    }
    if(fallbackOnTextTheme){
      final Color? res = theme.primaryTextTheme.bodyText2?.color;
      if(res!=null) return res;
    }

    return primary.contrast;
  }

  Color onColor(Color color) {
    final Color accent = theme.accentColor;
    final Color primary = theme.primaryColor;

    if(primary.legibleOn(color))
      return primary;
    else if(accent.legibleOn(color))
      return accent;

    return color.contrast;
  }

}