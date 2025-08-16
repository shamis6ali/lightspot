// lib/main.dart
import 'package:flutter/material.dart';
import 'common/data/app_preferences.dart';
import 'common/di/injection_container.dart';
import 'common/util/nav.dart';
import 'features/bottom_navigation/cubits/navigation_cubit.dart';
import 'features/bottom_navigation/widgets/navigation_container.dart';
import 'features/splash/splash_page.dart';
import 'package:nav/nav.dart';

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
    return MaterialApp(
      title: 'Photography Spots',
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          NavHelper.init(context);
          return const SplashPage();
        }
      ),
    );
  }
}
