import 'package:demo/User_Interface/widgets/Avatar_information.dart';
import 'package:demo/provider/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../App_Router/App_Router.dart';
// import 'package:iosstyleswitch/iosstyleswitch.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<AppProvider>(context).isDark
          ? Colors.black
          : Colors.white,
      body: Column(
        children: [
          AvatarWidget(),
          SizedBox(height: 20.h),
          Divider(
            color: Provider.of<AppProvider>(context).isDark
                ? Colors.white
                : Colors.black,
            height: 1,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Provider.of<AppProvider>(context).isDark
                        ? Colors.grey.shade900
                        : Colors.grey.shade300,
                    height: kToolbarHeight,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "CONTENT".tr(),
                            style: TextStyle(fontSize: 18.w),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Favorites".tr(),
                      style: TextStyle(
                          fontSize: 18.h,
                          color: Provider.of<AppProvider>(context).isDark
                              ? Colors.white
                              : Colors.black),
                    ),
                    leading: Icon(
                      Icons.favorite_border,
                      color: Provider.of<AppProvider>(context).isDark
                          ? Colors.white
                          : Colors.black,
                      size: 30.h,
                    ),
                    tileColor: Provider.of<AppProvider>(context).isDark
                        ? Colors.black
                        : Colors.white,
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      AppRouter.router.push("FilteredTripScreen");
                    },
                  ),
                  Opacity(
                    opacity: Provider.of<AppProvider>(context).isDark ? 1 : 0.2,
                    child: Divider(
                      color: Provider.of<AppProvider>(context).isDark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "BookMarked".tr(),
                      style: TextStyle(
                          fontSize: 18.h,
                          color: Provider.of<AppProvider>(context).isDark
                              ? Colors.white
                              : Colors.black),
                    ),
                    tileColor: Provider.of<AppProvider>(context).isDark
                        ? Colors.black
                        : Colors.white,
                    leading: Icon(
                      Icons.bookmark,
                      color: Provider.of<AppProvider>(context).isDark
                          ? Colors.white
                          : Colors.black,
                      size: 30.h,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      AppRouter.router.push('BookedMarkedScreen');
                    },
                  ),
                  Container(
                    color: Provider.of<AppProvider>(context).isDark
                        ? Colors.grey.shade900
                        : Colors.grey.shade300,
                    height: kToolbarHeight,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text(
                            "PREFERENCES".tr(),
                            style: TextStyle(fontSize: 18.w),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Language".tr(),
                      style: TextStyle(fontSize: 18.h),
                    ),
                    leading: Icon(
                      Icons.language,
                      color: Provider.of<AppProvider>(context).isDark
                          ? Colors.white
                          : Colors.black,
                      size: 30.h,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      if (context.locale == const Locale('en')) {
                        context.setLocale(const Locale('ar'));
                      } else {
                        context.setLocale(const Locale('en'));
                      }
                    },
                  ),
                  Opacity(
                    opacity: Provider.of<AppProvider>(context).isDark ? 1 : 0.2,
                    child: Divider(
                      color: Provider.of<AppProvider>(context).isDark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "DarkMode".tr(),
                      style: TextStyle(fontSize: 18.h),
                    ),
                    leading: Icon(
                      Icons.dark_mode_outlined,
                      color: Provider.of<AppProvider>(context).isDark
                          ? Colors.white
                          : Colors.black,
                      size: 30.h,
                    ),
                    trailing: CupertinoSwitch(
                      value: Provider.of<AppProvider>(context).isDark,
                      onChanged: (value) {
                        Provider.of<AppProvider>(context, listen: false)
                            .setDarkMode();
                      },
                      activeColor: Colors.blue,
                    ),
                  ),
                  Opacity(
                    opacity: Provider.of<AppProvider>(context).isDark ? 1 : 0.2,
                    child: Divider(
                      color: Provider.of<AppProvider>(context).isDark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      await Provider.of<AppProvider>(context, listen: false)
                          .getHistory();
                      AppRouter.router.push("History");
                    },
                    title: Text(
                      "History".tr(),
                      style: TextStyle(fontSize: 18.h),
                    ),
                    leading: Icon(
                      Icons.history,
                      color: Provider.of<AppProvider>(context).isDark
                          ? Colors.white
                          : Colors.black,
                      size: 30.h,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  Opacity(
                    opacity: Provider.of<AppProvider>(context).isDark ? 1 : 0.2,
                    child: Divider(
                      color: Provider.of<AppProvider>(context).isDark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      AppRouter.router.push("ContactUs");
                    },
                    title: Text(
                      "Contact Us".tr(),
                      style: TextStyle(fontSize: 18.h),
                    ),
                    leading: Icon(
                      Icons.contact_mail,
                      color: Provider.of<AppProvider>(context).isDark
                          ? Colors.white
                          : Colors.black,
                      size: 30.h,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  SizedBox(
                    width: 155.w,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<AppProvider>(context, listen: false)
                            .logOut();
                        AppRouter.router.pushReplace("WelcomeScreen");
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        shape: StadiumBorder(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Log_Out".tr(),
                            style: TextStyle(fontSize: 16.w),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}
