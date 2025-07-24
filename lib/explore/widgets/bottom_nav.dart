// lib/widgets/bottom_nav.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../view/explore_page.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.items = _defaultItems,
    this.height = 70,
  });

  /// Zero-based index of the active tab.
  final int currentIndex;

  /// Called with the index that was tapped.
  final ValueChanged<int> onTap;

  /// List of (icon, label) pairs.
  final List<(IconData, String)> items;

  /// Height of the bar (allows safe-area padding to be added outside).
  final double height;

  static const _defaultItems = [
    (FontAwesomeIcons.compass,  'Explore'),
    (FontAwesomeIcons.bookmark, 'Saved'),
    (FontAwesomeIcons.fire,     'Trending'),
    (FontAwesomeIcons.users,    'Community'),
    (FontAwesomeIcons.gear,     'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: height,
      child: Container(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (var i = 0; i < items.length; i++)
              _NavItem(
                icon:  items[i].$1,
                label: items[i].$2,
                selected: i == currentIndex,
                onTap: () => onTap(i),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String   label;
  final bool     selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.accent : Colors.grey;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 11, color: color)),
        ],
      ),
    );
  }
}
