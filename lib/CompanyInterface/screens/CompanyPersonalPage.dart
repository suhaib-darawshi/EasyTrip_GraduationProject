import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/CompanyInterface/widgets/CAvatar.dart';
import 'package:demo/provider/CompanyProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CPersonalPage extends StatelessWidget {
  const CPersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(builder: (context, provider, c) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: provider.isDark ? Colors.black : Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: provider.isDark ? Colors.white : Colors.black,
            ),
            onPressed: () => AppRouter.router.pop(),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  provider.setLocaleFromButton();
                  context.setLocale(provider.getLocale());
                },
                icon: Icon(
                  Icons.language,
                  color: Colors.blue,
                ))
          ],
        ),
        body: Column(
          children: [
            CompanyAvatar(),
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: provider.isDark
                      ? Colors.grey.shade900
                      : Colors.grey.shade300,
                  height: kToolbarHeight,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Statistics".tr(),
                          style: TextStyle(
                              fontSize: 18.w,
                              color: provider.isDark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                Opacity(
                  opacity: provider.isDark ? 1 : 0.2,
                  child: Divider(
                    color: provider.isDark ? Colors.white : Colors.black,
                    height: 1,
                  ),
                ),
                ListTile(
                  title: Text(
                    "mytrips".tr(),
                    style: TextStyle(
                        fontSize: 18.h,
                        color: provider.isDark ? Colors.white : Colors.black),
                  ),
                  leading: Icon(
                    Icons.flight,
                    color: provider.isDark ? Colors.white : Colors.black,
                    size: 30.h,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: provider.isDark ? Colors.white : Colors.black),
                  onTap: () {
                    if (context.locale == const Locale('en')) {
                      context.setLocale(const Locale('ar'));
                    } else {
                      context.setLocale(const Locale('en'));
                    }
                  },
                ),
                Container(
                  color: provider.isDark
                      ? Colors.grey.shade900
                      : Colors.grey.shade300,
                  height: kToolbarHeight,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          "PREFERENCES".tr(),
                          style: TextStyle(
                              fontSize: 18.w,
                              color: provider.isDark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                Opacity(
                  opacity: provider.isDark ? 1 : 0.2,
                  child: Divider(
                    color: provider.isDark ? Colors.white : Colors.black,
                    height: 1,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Language".tr(),
                    style: TextStyle(
                        fontSize: 18.h,
                        color: provider.isDark ? Colors.white : Colors.black),
                  ),
                  leading: Icon(
                    Icons.language,
                    color: provider.isDark ? Colors.white : Colors.black,
                    size: 30.h,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: provider.isDark ? Colors.white : Colors.black),
                  onTap: () {
                    if (context.locale == const Locale('en')) {
                      context.setLocale(const Locale('ar'));
                    } else {
                      context.setLocale(const Locale('en'));
                    }
                  },
                ),
                Opacity(
                  opacity: provider.isDark ? 1 : 0.2,
                  child: Divider(
                    color: provider.isDark ? Colors.white : Colors.black,
                  ),
                ),
                ListTile(
                  title: Text(
                    "DarkMode".tr(),
                    style: TextStyle(
                        fontSize: 18.h,
                        color: provider.isDark ? Colors.white : Colors.black),
                  ),
                  leading: Icon(
                    Icons.dark_mode_outlined,
                    color: provider.isDark ? Colors.white : Colors.black,
                    size: 30.h,
                  ),
                  trailing: CupertinoSwitch(
                    value: provider.isDark,
                    onChanged: (value) {
                      provider.setDarkMode();
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 155.w,
                  height: 45.h,
                  child: ElevatedButton(
                    onPressed: () {
                      provider.logOut();
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
            )))
          ],
        ),
        backgroundColor: provider.isDark ? Colors.black : Colors.white,
      );
    });
  }
}
