import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/di/injection_container.dart';
import '../../../common/theme/app_colors.dart';
import '../cubits/navigation_cubit.dart';
import '../user_nav_item.dart';

class CustomBottomNav extends StatelessWidget {
  final List<UserNavItem> items;
  final Color? selectedIconColor;
  final Color? unSelectedIconColor;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? centerItemColor;
  final bool Function(int index)? onPageChanged;

  const CustomBottomNav({
    super.key,
    required this.items,
    this.selectedIconColor,
    this.unSelectedIconColor,
    this.titleColor,
    this.centerItemColor,
    this.onPageChanged,
    this.backgroundColor,
  }) : assert((items.length % 2 == 1) && items.length >= 3,
            'Must be odd and >= 3');

  @override
  Widget build(BuildContext context) {
    final centerIndex = items.length ~/ 2;
    return BlocProvider(
      create: (context) => sl<NavigationCubit>(),
      child: ValueListenableBuilder(
        valueListenable: sl<NavigationCubit>().currentIndexNotifier,
        builder: (context, currentIndex, child) => Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: items.map((e) => e.screen).toList(),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.primary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final UserNavItem item = items[index];
                final isSelected = index == currentIndex;
                final icon =
                    isSelected ? item.selectedIcon : item.unSelectedIcon;
                final iconColor =
                    isSelected ? selectedIconColor : unSelectedIconColor;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _changePage(index);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      color: backgroundColor ?? AppColors.primary,
                      padding: EdgeInsets.only(
                        bottom: isSelected ? 20 : 22,
                        top: isSelected ? 14 : 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: isSelected ? 26 : 20,
                            width: isSelected ? 26 : 20,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Center(
                                  child: Icon(
                                    icon,
                                    color: iconColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.title,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? selectedIconColor
                                      : unSelectedIconColor ?? AppColors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void _changePage(int index) {
    if (onPageChanged?.call(index) ?? true) {
      sl<NavigationCubit>().setCurrentIndex(index);
    }
  }
}