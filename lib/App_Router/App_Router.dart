import 'package:demo/provider/CompanyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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

  popUntil(String name) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(name));
  }
}
