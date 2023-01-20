import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/User_Interface/screens/DetailPage.dart';
import 'package:demo/provider/AdminProvider.dart';
import 'package:demo/provider/CompanyProvider.dart';
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

import 'CompanyInterface/screens/CConfirmSignUpScreen.dart';
import 'CompanyInterface/screens/CeditInfo.dart';
import 'CompanyInterface/screens/CompanyPersonalPage.dart';
import 'CompanyInterface/screens/CompanySignUp.dart';
import 'CompanyInterface/screens/EditTripScreen.dart';
import 'CompanyInterface/screens/EditTripScreen2.dart';
import 'CompanyInterface/screens/EditTripScreen3.dart';
import 'CompanyInterface/screens/HomeScreen.dart';
import 'CompanyInterface/screens/addCategoriesScreen.dart';
import 'CompanyInterface/screens/addTripScreen.dart';
import 'CompanyInterface/screens/addTripSecondScreen.dart';
import 'CompanyInterface/widgets/CompanyTripEditScreen.dart';
import 'User_Interface/screens/BookedMarkedScreen.dart';
import 'User_Interface/screens/ConfirmScreen.dart';
import 'User_Interface/screens/ContactUs.dart';
import 'User_Interface/screens/FilteredTripPage.dart';
import 'User_Interface/screens/History.dart';
import 'User_Interface/screens/account_information.dart';
import 'User_Interface/screens/introScreen.dart';
import 'User_Interface/screens/welcomeScreen.dart';
import 'adminInterface/screens/homescreen.dart';
import 'adminInterface/screens/signInScreen.dart';
import 'date_repo/database_handler.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SQL.sql.initDatabase();
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
          ChangeNotifierProvider(
            create: (context) {
              return AppProvider();
            },
          ),
          ChangeNotifierProvider(create: ((context) => AdminProvider())),
          ChangeNotifierProvider(
            create: (context) => CompanyProvider(),
          )
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
          theme: Provider.of<AppProvider>(context).isDark
              ? ThemeData.dark()
              : ThemeData.light(),
          navigatorKey: AppRouter.router.navigatorKey,
          title: 'Easy Trip',
          routes: {
            'Home': (context) => HomeView(),
            'sign_up': (context) => SignUp(),
            'update_user_page': (context) => UpdateUserPage(),
            'HomeScreen': (context) => HomeScreen(),
            "LogIn": (context) => LoginScreen(),
            "FilteredTripScreen": (context) => FilteredTripScreen(),
            "AccountInformation": (context) => AccountInformation(),
            "DetailPage": (context) => DetailPage(),
            "History": (context) => HistoryScreen(),
            "CompanySignUp": (context) => CompanySignUp(),
            'companyHomePage': (context) => CHomeScreen(),
            "AddTrip": (context) => AddTrip(),
            "CEditTripScreen": (context) => CEditTripScreen(),
            "EditTripScreen":(context) => EditTripScreen(),
            "EditTripScreen2":(context) => EditTripScreen2(),
            'AddTripScreen2': (context) => AddTripScreen2(),
            "EditTripScreen3":(context) => EditTripScreen3(),
            "AddCategoriesScreen": (context) => AddCategoriesScreen(),
            "WelcomeScreen": (context) => WelcomeScreen(),
            "ConfirmSignUpScreen": (context) => ConfirmSignUpScreen(),
            "CCofirmSignUpScreen": (context) => CCofirmSignUpScreen(),
            "BookedMarkedScreen": (context) => BookedMarkedScreen(),
            "CPersonalPage": (context) => CPersonalPage(),
            "CompanyEditInformationScreen": (context) =>
                CompanyEditInformationScreen(),
            "ContactUs": (context) => ContactUs(),
            "AdminSignIn": (context) => AdminSignIn(),
            "AdminHomeScreen": (context) => AdminHomeScreen()
          },
          home: IntroScreen(),
        );
      },
    );
  }
}

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
