import 'package:asdrome_pos/src/theme/color_schemes.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';


class ThemeManager {
  static ColorScheme getDynamicColorScheme(ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
    if (lightDynamic != null && darkDynamic != null) {
      // On Android S+ devices, use the provided dynamic color scheme.
      // (Recommended) Harmonize the dynamic color scheme's built-in semantic colors.
      return lightDynamic.harmonized();
    } else {
      // Otherwise, use fallback schemes.
      return lightColorScheme;
    }
  }

  static ThemeData getLightTheme(ColorScheme colorScheme) {
    return ThemeData(colorScheme: colorScheme, useMaterial3: true);
  }

  static ThemeData getDarkTheme(ColorScheme colorScheme) {
    return ThemeData(colorScheme: colorScheme, brightness: Brightness.dark, useMaterial3: true);
  }
}
