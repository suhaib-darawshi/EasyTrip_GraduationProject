import 'package:flutter/cupertino.dart';

class AppRouter {
  AppRouter._();
  static AppRouter router = AppRouter._();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  push(String name) {
    navigatorKey.currentState!.pushNamed(name);
  }

  pushReplace(String name) {
    navigatorKey.currentState!.pushReplacementNamed(name);
  }

  pop() {
    navigatorKey.currentState!.pop();
  }
}
