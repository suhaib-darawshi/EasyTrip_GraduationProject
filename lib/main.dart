import 'package:demo/date_repo/data_provider.dart';
import 'package:demo/views/screens/View.dart';
import 'package:demo/views/screens/login_screen.dart';
import 'package:demo/views/screens/sign_up_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
      child: ChangeNotifierProvider<AppProvider>(
        create: (context) {
          return AppProvider();
        },
        child: Builded(),
      ),
    );
  }
}

class Builded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 891),
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          routes: {
            'Home': (context) => HomeView(),
            'sign_up':(context) => SignUp()
          },
          home: LoginScreen(),
        );
      },
    );
  }
}
