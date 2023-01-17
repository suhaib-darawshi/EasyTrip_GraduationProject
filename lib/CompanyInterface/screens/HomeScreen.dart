import 'package:demo/CompanyInterface/widgets/AllTripScreen.dart';
import 'package:demo/CompanyInterface/widgets/CActiveScreen.dart';
import 'package:demo/CompanyInterface/widgets/CNonActiveScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';
import '../../provider/CompanyProvider.dart';

class CHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Consumer<CompanyProvider>(builder: (context, provider, c) {
        return Scaffold(
          backgroundColor: provider.isDark ? Colors.black : Colors.white,
          drawer: Drawer(
            backgroundColor: provider.isDark ? Colors.black : Colors.white,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 4.6,
                  child: Stack(fit: StackFit.expand, children: [
                    Image.network(
                      provider.user.logo,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        bottom: 50,
                        left: 15,
                        child: Text(
                          provider.user.name,
                          style: TextStyle(fontSize: 18.w),
                        )),
                    Positioned(
                        bottom: 15,
                        left: 15,
                        child: Text(
                          provider.user.email,
                          style: TextStyle(fontSize: 18.w),
                        ))
                  ]),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ListTile(
                  onTap: () {
                    AppRouter.router.push("CPersonalPage");
                  },
                  leading: Icon(
                    Icons.person,
                    color: provider.isDark ? Colors.white : Colors.black,
                  ),
                  title: Text(
                    "Personal Page".tr(),
                    style: TextStyle(
                        color: provider.isDark ? Colors.white : Colors.black),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: provider.isDark ? Colors.white : Colors.black,
                  ),
                ),
                Divider(
                  color: provider.isDark ? Colors.white : Colors.black,
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
            ),
          ),
          appBar: AppBar(
            backgroundColor: provider.isDark ? Colors.black : Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    Provider.of<CompanyProvider>(context, listen: false)
                        .setLocaleFromButton();
                    context.setLocale(
                        Provider.of<CompanyProvider>(context, listen: false)
                            .getLocale());
                  },
                  icon: Icon(
                    Icons.language,
                    color: provider.isDark ? Colors.white : Colors.black,
                  ))
            ],
            leading: Builder(builder: (context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  color: provider.isDark ? Colors.white : Colors.black,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            }),
            bottom: TabBar(tabs: [
              Container(
                height: 30.h,
                child: Center(
                  child: Text(
                    'All Trips'.tr(),
                    style: TextStyle(
                        color: Provider.of<CompanyProvider>(context).isDark
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
              Container(
                height: 30.h,
                child: Center(
                  child: Text(
                    'Active Trips'.tr(),
                    style: TextStyle(
                        color: Provider.of<CompanyProvider>(context).isDark
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    'non-active Trips'.tr(),
                    style: TextStyle(
                        color: Provider.of<CompanyProvider>(context).isDark
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              )
            ]),
          ),
          body: TabBarView(
              children: [AllTrips(), ActiveTrips(), NonActiveTrips()]),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Provider.of<CompanyProvider>(context, listen: false).imageFile =
                  null;
              AppRouter.router.push("AddTrip");
            },
            child: Icon(
              Icons.add,
              size: 35.w,
            ),
          ),
        );
      }),
    );
  }
}
