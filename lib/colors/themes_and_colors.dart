import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

extension ThemeDataSid on ThemeData {

  bool get isLight => this.brightness.isLight;
  bool get isDark => this.brightness.isDark;

}

extension ColorSid on Color {
  Brightness get brightness => ThemeData.estimateBrightnessForColor(this);
  bool get isDark => this.brightness == Brightness.dark;
  bool get isLight => !this.isDark;
  Color get contrast => this.isDark ? Colors.white : Colors.black;

  bool sameBrightnessAs(Color other) => this.brightness == other.brightness;
  bool notLegibleOn(Color other) => this.sameBrightnessAs(other);
  bool legibleOn(Color other) => !this.notLegibleOn(other);
}

extension BrightnessSid on Brightness {
  String get name => _Brightness.names[this];

  IconData get icon => _Brightness.icons[this];

  Color get contrast => this.isLight ? Colors.black : Colors.white;

  bool get isLight => this == Brightness.light;
  bool get isDark => !isLight;

  Brightness get opposite => this.isLight ? Brightness.dark : Brightness.light;
}

class _Brightness {
  static const Map<Brightness, String> names = <Brightness,String>{
    Brightness.dark: "Dark",
    Brightness.light: "Light",
  };

  // static const Map<String,Brightness> invertedNames = <String,Brightness>{
  //   "Light": Brightness.light,
  //   "Dark": Brightness.dark,
  // };
  // static Brightness fromName(String name) => invertedNames[name];

  static const Map<Brightness,IconData> icons = <Brightness,IconData>{
    Brightness.light: MaterialCommunityIcons.weather_sunny,
    Brightness.dark: MaterialCommunityIcons.weather_night,
  };
}
