// lib/main.dart
import 'package:flutter/material.dart';
import 'package:lightspot_v1/common/data/app_preferences.dart';
import 'package:lightspot_v1/common/di/injection_container.dart';
import 'package:lightspot_v1/common/theme/theme_provider.dart';
import 'package:lightspot_v1/common/util/nav.dart';
import 'package:lightspot_v1/features/bottom_navigation/cubits/navigation_cubit.dart';
import 'package:lightspot_v1/features/bottom_navigation/widgets/navigation_container.dart';
import 'package:lightspot_v1/features/splash/splash_page.dart';
import 'package:nav/nav.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await AppPreferences.init();
  runApp(const PhotographySpotsApp());
}

class PhotographySpotsApp extends StatelessWidget {
  const PhotographySpotsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Photography Spots',
            theme: themeProvider.getTheme(),
            debugShowCheckedModeBanner: false,
            home: Builder(
              builder: (context) {
                NavHelper.init(context);
                return const SplashPage();
              }
            ),
          );
        },
      ),
    );
  }
}
