import 'package:asdrome_pos/src/layout/home_view.dart';
import 'package:asdrome_pos/src/manage_products/add_product_view.dart';
import 'package:asdrome_pos/src/manage_products/products_controller.dart';
import 'package:asdrome_pos/src/theme/theme.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:asdrome_pos/src/theme/color_schemes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {

    return _buildListenableBuilder(context);
  }

    Widget _buildListenableBuilder(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return _buildDynamicColorBuilder(context);
      },
    );
  }

  Widget _buildDynamicColorBuilder(BuildContext context) {
    return DynamicColorBuilder(
            builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          ColorScheme light = lightColorScheme;
          ColorScheme dark = darkColorScheme;
          if (lightDynamic != null && darkDynamic != null) {
            // On Android S+ devices, use the provided dynamic color scheme.
            // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
            light = lightDynamic.harmonized();
            dark = darkDynamic.harmonized();
          }
          // Otherwise, use fallback schemes.

          return _buildApp(context, ThemeManager.getLightTheme(colorScheme: light), ThemeManager.getDarkTheme(colorScheme: dark));
        });
  }
    

  Widget _buildApp(BuildContext context, ThemeData theme, ThemeData darkTheme) {
    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en', ''), // English, no country code
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: settingsController.themeMode,
      onGenerateRoute: (RouteSettings routeSettings) => MaterialPageRoute<void>(
        settings: routeSettings,
        builder: (BuildContext context) => _buildRoutes(routeSettings),
      ),
    );
  }

  Widget _buildRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SettingsView.routeName:
        return SettingsView(controller: settingsController);
      case SampleItemDetailsView.routeName:
        return const SampleItemDetailsView();
      case SampleItemListView.routeName:
        return const SampleItemListView();
      default:
        return AddProductView(controller: ProductsController());
    }
  }
}
