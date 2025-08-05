import 'package:flutter/material.dart';
import 'package:lightspot_v1/common/di/injection_container.dart';
import 'package:lightspot_v1/common/theme/app_colors.dart';
import 'package:lightspot_v1/features/bottom_navigation/cubits/navigation_cubit.dart';
import 'package:lightspot_v1/features/bottom_navigation/user_nav_item.dart';
import 'package:lightspot_v1/features/bottom_navigation/widgets/custom_bottom_nav.dart';
import 'package:nav/nav.dart';

class NavigationContainer extends StatefulWidget {
  const NavigationContainer({super.key});

  @override
  State<NavigationContainer> createState() =>
      NavigationContainerState();
}

class NavigationContainerState extends State<NavigationContainer>
    with SingleTickerProviderStateMixin {
  bool get extendBody => true;

  @override
  void initState() {
    super.initState();
    final navigationCubit = sl<NavigationCubit>();
    navigationCubit.setCurrentIndex(0);
  }
  
  @override
  Widget build(BuildContext context) {
    final navigationCubit = sl<NavigationCubit>();
    return PopScope(
      canPop: navigationCubit.isRootPage,
      onPopInvoked: _handleBackPressed,
      child: CustomBottomNav(
        items: navigationCubit.tabs,
        onPageChanged: _changeTab,
        selectedIconColor: AppColors.bottomNavSelected,
        unSelectedIconColor: AppColors.bottomNavUnselected,
        backgroundColor: AppColors.bottomNavBackground,
        titleColor: AppColors.bottomNavSelected,
      ),
    );
  }

  void _handleBackPressed(bool didPop) {
    final navigationCubit = sl<NavigationCubit>();
    if (!didPop) {
      if (navigationCubit.currentTabNavigationKey.currentState?.canPop() ==
          true) {
        Nav.pop(navigationCubit.currentTabNavigationKey.currentContext!);
        return;
      }

      if (navigationCubit.currentTab != UserNavItem.explore) {
        _changeTab(navigationCubit.tabs.indexOf(UserNavItem.explore));
      }
    }
  }

  bool _changeTab(int index) {
    // final isGuest = GuestUtil.isGuest;
   return true;
  }
}