import 'package:demo/api/api_helper.dart';
import 'package:demo/provider/AdminProvider.dart';
import 'package:demo/provider/CompanyProvider.dart';
import 'package:demo/provider/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'App_Router/App_Router.dart';
import 'User_Interface/screens/loginScreen.dart';
import 'adminInterface/screens/AdminChat.dart';
import 'adminInterface/screens/homescreen.dart';
import 'adminInterface/screens/signInScreen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  API.apiHandler.server = 'http://localhost:8083/';
  runApp(Mat());
}

class Mat extends StatelessWidget {
  const Mat({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/languages',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ((context) => AdminProvider())),
          ChangeNotifierProvider(
            create: (context) => CompanyProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AppProvider(),
          )
        ],
        child: Build(),
      ),
    );
  }
}

class Build extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: Provider.of<AdminProvider>(context).isDark
              ? ThemeData.dark()
              : ThemeData.light(),
          navigatorKey: AppRouter.router.navigatorKey,
          routes: {
            "AdminSignIn": (context) => const AdminSignIn(),
            "AdminHomeScreen": (context) => AdminHomeScreen(),
            "AdminChatScreen": (context) => AdminChatScreen()
          },
          home: const AdminSignIn(),
        );
      },
    );
  }
}
