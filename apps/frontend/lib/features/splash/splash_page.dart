import 'package:flutter/material.dart';
import 'package:lightspot_v1/common/data/app_preferences.dart';
import 'package:lightspot_v1/common/util/nav.dart';
import 'package:lightspot_v1/features/auth/presentation/pages/login_screen.dart';
import 'package:lightspot_v1/features/bottom_navigation/widgets/navigation_container.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Future.delayed(const Duration(seconds: 2), () {
      final bool isLoggedIn = AppPreferences.getIsLoggedIn();
      if (isLoggedIn) {
        NavHelper.pushReplacement(page: const NavigationContainer(), context: context);
      } else {
          NavHelper.pushReplacement(page: const LoginScreen(), context: context);
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Splash Page')));
  }
}