
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:lightspot_v1/common/dart/base_cubit.dart';
import 'package:lightspot_v1/common/dart/request_state.dart';
import 'package:lightspot_v1/features/bottom_navigation/cubits/navigation_variables.dart';
import 'package:lightspot_v1/features/bottom_navigation/user_nav_item.dart';


part 'navigation_state.dart';

@Singleton()
class NavigationCubit extends BaseCubit<NavigationState>
    with NavigationVariables {
  NavigationCubit() : super(NavigationState.initial()) {
    _initNavigatorKeys();
  }

  UserNavItem get currentTab => currentTabNotifier.value;

  int get currentIndex => currentIndexNotifier.value;

  setCurrentTab(UserNavItem tab) {
    currentTabNotifier.value = tab;
    currentIndexNotifier.value = tabs.indexOf(tab);
  }

  setCurrentIndex(int index) {
    currentTabNotifier.value = tabs[index];
    currentIndexNotifier.value = index;
  }

  GlobalKey<NavigatorState> get currentTabNavigationKey =>
      navigatorKeys[currentIndex];

  bool get isRootPage =>
      currentTab == UserNavItem.explore &&
      currentTabNavigationKey.currentState?.canPop() == false;

  void _initNavigatorKeys() {
    for (final _ in tabs) {
      navigatorKeys.add(GlobalKey<NavigatorState>());
    }
  }

  IndexedStack get pages => IndexedStack(
        index: currentIndex,
        children: tabs
            .asMap()
            .entries
            .map((entry) => Offstage(
                  offstage: currentTab != entry.value,
                  child: entry.value.screen,
                ))
            .toList(),
      );
}
