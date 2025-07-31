import 'package:flutter/cupertino.dart';

import '../user_nav_item.dart';

mixin NavigationVariables {
  final List<GlobalKey<NavigatorState>> navigatorKeys = [];

  final tabs = UserNavItem.values;
  final ValueNotifier<UserNavItem> currentTabNotifier = ValueNotifier(UserNavItem.explore);
  final ValueNotifier<int> currentIndexNotifier = ValueNotifier(0);
}
