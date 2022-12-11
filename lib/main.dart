import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/User_Interface/screens/DetailPage.dart';
import 'package:demo/provider/app_provider.dart';
import 'package:demo/User_Interface/screens/HomeScreen.dart';
import 'package:demo/User_Interface/screens/View.dart';
import 'package:demo/User_Interface/screens/login_screen.dart';
import 'package:demo/User_Interface/screens/searchScreen.dart';
import 'package:demo/User_Interface/screens/sign_up_screen.dart';
import 'package:demo/User_Interface/screens/updateinformation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'User_Interface/screens/FilteredTripPage.dart';
import 'User_Interface/screens/account_information.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  runApp(Material());
}

class Material extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/languages',
      fallbackLocale: Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create:  (context) {
          return AppProvider();
        },)
        ],
        
        child: Builded(),
      ),
    );
  }
}

class Builded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 891),
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          navigatorKey: AppRouter.router.navigatorKey,
          routes: {
            'Home': (context) => HomeView(),
            'sign_up':(context) => SignUp(),
            'update_user_page':(context) => UpdateUserPage(),
            'HomeScreen':(context) => HomeScreen(),
            "LogIn":(context) => LoginScreen(),
            "FilteredTripScreen":(context) => FilteredTripScreen(),
            "AccountInformation":(context) => AccountInformation(),
            "DetailPage":(context) => DetailPage()
          },
          home: LoginScreen(),
        );
      },
    );
  }
}
