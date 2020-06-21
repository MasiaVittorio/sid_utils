import 'package:flutter/material.dart';


/// Nord consists of four named color palettes providing different syntactic 
/// meanings and color effects for dark & bright ambiance designs.
///
/// All colors are numbered from nord0 to nord15 where each palette contains a different amount of colors. 
/// 
/// The naming convention preserves the compatibility for terminal color schemes and allows an uncomplicated use as base for such.
class NordTheme {

  // Origin colors
  static const int _nord0 = 0xFF2E3440; /// Polar Night
  static const int _nord4 = 0xFFD8DEE9; /// Snow Storm 
  static const int _nord8 = 0xFF88C0D0; /// Frost 
  static const int _nord12 = 0xFFD08770; /// Aurora 


  /// Polar Night (default: 0)
  static const Color nord0 = Color(_nord0); /// polarNight / polarNight[0]
  static const Color nord1 = Color(0xFF3B4252); /// polarNight[1]
  static const Color nord2 = Color(0xFF434C5E); /// polarNight[2]
  static const Color nord3 = Color(0xFF4C566A); /// polarNight[3]

  /// Snow Storm (default 4)
  static const Color nord4 = Color(_nord4); /// snowStorm / snowStorm[4],
  static const Color nord5 = Color(0xFFE5E9F0); /// snowStorm[5],
  static const Color nord6 = Color(0xFFECEFF4); /// snowStorm[6],

  /// Frost (default: 8)
  static const Color nord7 = Color(0xFF8FBCBB); /// frost[7]
  static const Color nord8 = Color(_nord8); /// frost / frost[8]
  static const Color nord9 = Color(0xFF81A1C1); /// frost[9]
  static const Color nord10 = Color(0xFF5E81AC); /// frost[10]

  /// Aurora (default: 11)
  static const Color nord11 = Color(0xFFBF616A); /// aurora[11]
  static const Color nord12 = Color(_nord12); /// aurora / aurora[12]
  static const Color nord13 = Color(0xFFEBCB8B); /// aurora[13]
  static const Color nord14 = Color(0xFFA3BE8C); /// aurora[14]
  static const Color nord15 = Color(0xFFB48EAD); /// aurora[15]


  /// Polar Night is made up of four darker colors that are commonly used for 
  /// base elements like backgrounds or text color in bright ambiance designs.
  static const ColorSwatch polarNight = ColorSwatch(_nord0, 
    <int,Color>{
      /// The origin color or the Polar Night palette.
      /// For dark ambiance designs, it is used for background and area coloring while it's not used for syntax highlighting at all because otherwise it would collide with the same background color.
      /// For bright ambiance designs, it is used for base elements like plain text, the text editor caret and reserved syntax characters like curly- and square brackets.
      /// It is rarely used for passive UI elements like borders, but might be possible to achieve a higher contrast and better visual distinction (harder/not flat) between larger components.
      0: nord0,

      /// A brighter shade color based on nord0.
      /// For dark ambiance designs it is used for elevated, more prominent or focused UI elements.
      /// For bright ambiance designs, it is used for more subtle/inconspicuous UI text elements that do not need so much visual attention.
      /// Other use cases are also state animations like a more brighter text color when a button is hovered, active or focused.
      1: nord1,

      /// An even more brighter shade color of nord0.
      /// For dark ambiance designs, it is used to colorize the currently active text editor line as well as selection- and text highlighting color.
      /// For both bright & dark ambiance designs it can also be used as an brighter variant for the same target elements like nord1.
      2: nord2,

      /// The brightest shade color based on nord0.
      /// For dark ambiance designs, it is used for UI elements like indent- and wrap guide marker.
      /// In the context of code syntax highlighting it is used for comments and invisible/non-printable characters.
      /// For bright ambiance designs, it is, next to nord1 and nord2 as darker variants, also used for the most subtle/inconspicuous UI text elements that do not need so much visual attention.
      3: nord3,
    },
  );

  /// Snow Storm is made up of three bright colors that are commonly used 
  /// for text colors or base UI elements in bright ambiance designs.
  /// 
  /// The palette can be used for two different shading ambiance styles:
  ///  - bright to dark — This is the recommended style that uses nord6 as base color and highlights other UI elements with nord5 and nord4.
  ///  - dark to bright (semi-light) — This style uses nord4 as base color and highlights other UI elements with nord5 and nord6.
  /// The documentation of the different colors from this palette are based on the recommended bright to dark ambiance style.
  /// To apply the color purposes to the dark to bright style the definitions can be used in reversed order.
  static const ColorSwatch snowStorm = ColorSwatch(_nord4, 
    <int,Color>{
      /// The origin color or the Snow Storm palette.
      /// For dark ambiance designs, it is used for UI elements like the text editor caret.
      /// For bright ambiance designs, it is used for elevated, more prominent or focused UI elements
      4: nord4,

      /// A brighter shade color of nord4.
      /// For dark ambiance designs, it is used for more subtle/inconspicuous UI text elements that do not need so much visual attention.
      /// Other use cases are also state animations like a more brighter text color when a button is hovered, active or focused.
      /// For bright ambiance designs, it is used to colorize the currently active text editor line as well as selection- and text highlighting color.
      5: nord5,

      /// The brightest shade color based on nord4.
      /// For dark ambiance designs, it is used for elevated UI text elements that require more visual attention.
      /// For bright ambiance designs, it is used as background and area coloring while it's not used for syntax highlighting at all.
      6: nord6,
    },
  );

  /// Frost can be described as the heart palette of Nord, a group of four bluish colors that are commonly used 
  /// for primary UI component and text highlighting and essential code syntax elements.
  /// All colors of this palette are used the same for both dark & bright ambiance designs.
  static const ColorSwatch frost = ColorSwatch(_nord8,
    <int,Color>{
      /// A calm and highly contrasted color reminiscent of frozen polar water.
      /// Used for UI elements that should, next to the primary accent color nord8, stand out and get more visual attention.
      7: nord7, 

      /// The bright and shiny primary accent color reminiscent of pure and clear ice.
      /// Used for primary UI elements with main usage purposes that require the most visual attention.
      8: nord8, 

      /// A more darkened and less saturated color reminiscent of arctic waters.
      /// Used for secondary UI elements that also require more visual attention than other elements.
      9: nord9, 

      /// A dark and intensive color reminiscent of the deep arctic ocean.
      /// Used for tertiary UI elements that require more visual attention than default elements.
      10: nord10, 
    },
  );


  /// Aurora consists of five colorful components reminiscent of the "Aurora borealis".
  /// All colors of this palette are used the same for both dark & bright ambiance designs.
  static const ColorSwatch aurora = ColorSwatch(_nord12,
    <int,Color>{
      /// Used for UI elements that are rendering error states like linter markers and the highlighting of Git diff deletions.
      11: nord11,
      
      /// Rarely used for UI elements, but it may indicate a more advanced or dangerous functionality.
      12: nord12,

      /// Used for UI elements that are rendering warning states like linter markers and the highlighting of Git diff modifications.
      13: nord13,

      /// Used for UI elements that are rendering success states and visualizations and the highlighting of Git diff additions.
      14: nord14,

      /// Rarely used for UI elements, but it may indicate a more uncommon functionality.
      /// In the context of syntax highlighting it is used as main color for numbers of any type like integers and floating point numbers.
      15: nord15,
    },
  );


  static Color get _darkBackground => polarNight[0];
  static Color get _darkBackgroundElevated => polarNight[1];
  static Color get _darkBackgroundElevatedMore => polarNight[2];

  /// Bright to dark (recommended)
  static Color get _lightBackground => snowStorm[6];
  static Color get _lightBackgroundElevated => snowStorm[5];
  static Color get _lightBackgroundElevatedMore => snowStorm[4];

  /// Dark to bright (alternative)
  static Color get _altLightBackground => snowStorm[4];
  static Color get _altLightBackgroundElevated => snowStorm[5];
  static Color get _altLightBackgroundElevatedMore => snowStorm[6];


  static Color background(Brightness brightness, {bool alternativeLightTheme = false}) 
    => brightness == Brightness.dark ? _darkBackground : alternativeLightTheme ? _altLightBackground : _lightBackground;
  static Color backgroundElevated(Brightness brightness, {bool alternativeLightTheme = false}) 
    => brightness == Brightness.dark ? _darkBackgroundElevated : alternativeLightTheme ? _altLightBackgroundElevated : _lightBackgroundElevated;
  static Color backgroundElevatedMore(Brightness brightness, {bool alternativeLightTheme = false}) 
    => brightness == Brightness.dark ? _darkBackgroundElevatedMore : alternativeLightTheme ? _altLightBackgroundElevatedMore : _lightBackgroundElevatedMore;

  static Color get _darkText => snowStorm[6];
  static Color get _darkTextSubtle => snowStorm[5];
  static Color get _darkTextSubtleMore => snowStorm[5];
  static Color get _darkTextSubtleSuper => snowStorm[4];

  static Color get _lightText => polarNight[0];
  static Color get _lightTextSubtle => polarNight[1];
  static Color get _lightTextSubtleMore => polarNight[2];
  static Color get _lightTextSubtleSuper => polarNight[3];

  static Color text(Brightness brightness)
    => brightness == Brightness.dark ? _darkText : _lightText;
  static Color textSubtle(Brightness brightness)
    => brightness == Brightness.dark ? _darkTextSubtle : _lightTextSubtle;
  static Color textSubtleMore(Brightness brightness)
    => brightness == Brightness.dark ? _darkTextSubtleMore : _lightTextSubtleMore;
  static Color textSubtleSuper(Brightness brightness)
    => brightness == Brightness.dark ? _darkTextSubtleSuper : _lightTextSubtleSuper;


  static const Color accent = nord8; //frost / frost[8]
  static Color get accent2 => frost[7];
  static Color get accent3 => frost[9];
  static Color get accent4 => frost[10];

  static Color get error => aurora[11]; //dark red
  static Color get danger => aurora; //12 // red
  static Color get warning => aurora[13]; // yellow
  static Color get success => aurora[14]; // green
  static Color get uncommon => aurora[15]; // grey-ish

}

