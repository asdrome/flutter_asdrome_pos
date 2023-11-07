import 'package:asdrome_pos/src/theme/color_schemes.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';



class ThemeManager {

  static ThemeData getLightTheme({ColorScheme? colorScheme = lightColorScheme}) {
    return ThemeData(
      colorScheme: colorScheme,
       useMaterial3: true);
  }

  static ThemeData getDarkTheme({ColorScheme? colorScheme = darkColorScheme}) {
    return ThemeData(
      colorScheme: colorScheme,
      brightness: Brightness.dark,
      useMaterial3: true);
  }
}
class ThemedApp extends StatelessWidget {

  const ThemedApp({super.key});


  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {

        return MaterialApp(
            // Define a light and dark color theme. Then, read the user's
            // preferred ThemeMode (light, dark, or system default) from the
            // SettingsController to display the correct theme.
            theme: ThemeManager.getLightTheme(colorScheme:lightDynamic),
            darkTheme: ThemeManager.getDarkTheme(colorScheme:darkDynamic),

        );
      }
    );
  }

}