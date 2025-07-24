// lib/widgets/tag_filter_row.dart
import 'package:flutter/material.dart';
import '../view/explore_page.dart';          // Prefer a small colors file
// ↑ remove the explore_page import; you only needed AppColors.

// A PRESENTATION-ONLY WIDGET
class TagFilterRow extends StatelessWidget {
  const TagFilterRow({
    super.key,
    required this.tags,         // list of (icon, label) tuples
    required this.activeIndex,  // which chip is currently "on"
    required this.onSelected,   // callback(index)
  });

  final List<(IconData, String)> tags;
  final int                      activeIndex;
  final ValueChanged<int>        onSelected;

  @override
  Widget build(BuildContext context) {
    final topInset         = MediaQuery.of(context).padding.top;
    const searchBarHeight  = 56.0;

    return Positioned(
      top: topInset + searchBarHeight - 10,
      left: 16,
      right: 0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            for (int i = 0; i < tags.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  backgroundColor:
                  activeIndex == i ? AppColors.primary : AppColors.darkGray,
                  avatar: Icon(tags[i].$1, size: 12, color: Colors.white),
                  label: Text(tags[i].$2,
                      style: const TextStyle(color: Colors.white)),
                  onSelected: (_) => onSelected(i),   // no setState here
                ),
              ),
          ],
        ),
      ),
    );
  }
}
