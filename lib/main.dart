// lib/main.dart
import 'package:flutter/material.dart';
import 'explore/view/explore_page.dart';
import 'explore/view/saved_page.dart';   // we just added this

void main() => runApp(const PhotographySpotsApp());

class PhotographySpotsApp extends StatelessWidget {
  const PhotographySpotsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photography Spots',
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      // initial route
      home: const ExplorePage(),
      // named routes for BottomNav
      routes: {
        '/explore': (_) => const ExplorePage(),
        '/saved'  : (_) => const SavedPage(),
      },
    );
  }
}
