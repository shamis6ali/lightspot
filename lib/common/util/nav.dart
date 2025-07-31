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
  static void push(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static void pushReplacement({required Widget page, BuildContext? context}) {
    Navigator.pushReplacement(context?? NavHelper.context , MaterialPageRoute(builder: (context) => page));
  }

  static void pushAndRemoveUntil(Widget page) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  static void pop() {
    Navigator.pop(context);
  }

  static void popUntil(Widget page) {
    Navigator.popUntil(context, ModalRoute.withName(page.toString()));
  }

  static void popToFirst() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}