// lib/widgets/tag_filter_row.dart
import 'package:flutter/material.dart';
import '../pages/explore_page.dart';          // Prefer a small colors file
// ↑ remove the explore_page import; you only needed AppColors.
import '../../../../common/theme/app_colors.dart';

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
      right: 16, // Add right padding to prevent overlap
      child: Container(
        height: 50, // Fixed height for the scrollable area
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Allow the row to be as wide as needed
            children: [
              for (int i = 0; i < tags.length; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _buildFilterChip(i),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(int index) {
    final isSelected = activeIndex == index;
    final (icon, label) = tags[index];

    return GestureDetector(
      onTap: () => onSelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.filterSelected 
              : AppColors.filterUnselected,
          borderRadius: BorderRadius.circular(25),
          border: isSelected
              ? Border.all(
                  color: AppColors.white.withOpacity(0.3),
                  width: 1.5,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? AppColors.shadowDark.withOpacity(0.3)
                  : AppColors.shadow.withOpacity(0.2),
              blurRadius: isSelected ? 8 : 4,
              offset: Offset(0, isSelected ? 3 : 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                icon,
                size: isSelected ? 14 : 12,
                color: AppColors.filterText,
              ),
            ),
            const SizedBox(width: 8),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color: AppColors.filterText,
                fontSize: isSelected ? 13 : 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                letterSpacing: isSelected ? 0.3 : 0.1,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
