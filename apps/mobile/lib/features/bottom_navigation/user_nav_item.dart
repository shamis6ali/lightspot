import 'package:flutter/material.dart';
import 'package:lightspot_v1/features/explore/presentation/pages/explore_page.dart';
import 'package:lightspot_v1/features/saved/presentation/pages/saved_page.dart';
import 'package:lightspot_v1/features/bottom_navigation/user_nav_item.dart';
import 'package:lightspot_v1/features/trending/presentation/pages/trending_page.dart';
import 'package:lightspot_v1/features/community/presentation/pages/community_page.dart';
import 'package:lightspot_v1/features/settings/presentation/pages/settings_page.dart';

enum UserNavItem {
  explore(
    title: 'Explore',
    selectedIcon: Icons.explore,
    unSelectedIcon: Icons.explore,
    screen: ExplorePage(),
  ),
  saved(
    title: 'Saved',
    selectedIcon: Icons.bookmark,
    unSelectedIcon: Icons.bookmark,
    screen: SavedPage(),
  ),
  trending(
    title: 'Trending',
    selectedIcon: Icons.trending_up,
    unSelectedIcon: Icons.trending_up,
    screen: TrendingPage(),
  ),
  community(
    title: 'Community',
    selectedIcon: Icons.people,
    unSelectedIcon: Icons.people,
    screen: CommunityPage(),
  ),
  settings(
    title: 'Settings',
    selectedIcon: Icons.settings,
    unSelectedIcon: Icons.settings,
    screen: SettingsPage(),
  );

  final String title;
  final IconData selectedIcon;
  final IconData unSelectedIcon;  
  final Widget screen;

  const UserNavItem({
    required this.title,
    required this.selectedIcon,
    required this.unSelectedIcon,
    required this.screen,
  });
}
