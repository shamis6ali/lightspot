import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/explore_page.dart';
import 'package:lightspot_v1/common/theme/app_colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    this.hintText = 'Search photography spots…',
    this.onChanged,
  });

  /// Placeholder text
  final String hintText;
  /// Callback on every keystroke
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
      final topInset = MediaQuery.of(context).padding.top;
  return Positioned(
    top: topInset + 12,
    left: 16,
    right: 16,
    child: Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(28),
      color: AppColors.lightGray.withOpacity(0.90),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search photography spots…',
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          prefixIcon: const Icon(
            FontAwesomeIcons.magnifyingGlass,
            size: 18,
            color: Colors.grey,
          ),
          suffixIcon: const Icon(
            FontAwesomeIcons.microphone,
            size: 18,
            color: Colors.grey,
          ),
        ),
      ),
    ),
  );
  }
}
