import 'package:flutter/material.dart';
import 'package:poke_master_detail/presentation/common/localization/app_localizations.dart';
import 'package:poke_master_detail/presentation/navigation/navigation_routes.dart';

import 'di/app_modules.dart';
import 'presentation/common/resources/app_styles.dart';

void main() {
  AppModules().setup(); // Setup dependency injection
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter MVVM - Poke API',
      theme: AppStyles.appTheme,
      darkTheme: AppStyles.appDarkTheme,
      themeMode: ThemeMode.system, // Enable automatic dark theme support
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.app_title,
      debugShowCheckedModeBanner: false,
    );
  }
}
