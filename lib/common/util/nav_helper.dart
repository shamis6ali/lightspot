import 'package:flutter/material.dart';

class NavHelper {
  NavHelper._();
  static late final BuildContext context;
  static bool isInitialized = false;
  static void init(BuildContext context) {
    if (isInitialized) return;
    NavHelper.context = context;
    isInitialized = true;
  }

  static void push({required Widget page, BuildContext? context}) {
    Navigator.push(context?? NavHelper.context, MaterialPageRoute(builder: (context) => page));
  }

  static void pushReplacement({required Widget page, BuildContext? context}) {
    Navigator.pushReplacement(context?? NavHelper.context, MaterialPageRoute(builder: (context) => page));
  }

  static void pushAndRemoveUntil({required Widget page, BuildContext? context}) {
    Navigator.pushAndRemoveUntil(context?? NavHelper.context, MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  static void pop({BuildContext? context}) {
    Navigator.pop(context?? NavHelper.context);
  }

  static void popUntil({required Widget page, BuildContext? context}) {
    Navigator.popUntil(context?? NavHelper.context, ModalRoute.withName(page.toString()));
  }

  static void popToFirst({BuildContext? context}) {
    Navigator.popUntil(context?? NavHelper.context, (route) => route.isFirst);
  }
}