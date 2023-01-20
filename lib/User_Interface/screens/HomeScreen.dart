import 'package:demo/provider/app_provider.dart';
import 'package:demo/User_Interface/screens/View.dart';
import 'package:demo/User_Interface/screens/searchScreen.dart';
import 'package:demo/User_Interface/screens/updateinformation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';
import '../widgets/SearchWdget.dart';

import 'personal_page.dart';

class HomeScreen extends StatelessWidget {
  List screens = [HomeView(), SearchScreen(), PersonalScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Provider.of<AppProvider>(context).isDark
            ? Colors.black
            : Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4.6,
              child: Stack(fit: StackFit.expand, children: [
                Image.network(
                  Provider.of<AppProvider>(context).user.image!,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    bottom: 50.h,
                    left: 15.w,
                    child: Text(
                      Provider.of<AppProvider>(context).user.first_name!,
                      style: TextStyle(fontSize: 18.w),
                    )),
                Positioned(
                    bottom: 15.h,
                    left: 15.w,
                    child: Text(
                      Provider.of<AppProvider>(context).user.email!,
                      style: TextStyle(fontSize: 18.w),
                    ))
              ]),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: 155.w,
              height: 45.h,
              child: ElevatedButton(
                onPressed: () {
                  AppRouter.router.push("update_user_page");
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  shape: StadiumBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Edit_Profile".tr(),
                      style: TextStyle(fontSize: 16.w, color: Colors.white),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
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
                      opacity:
                          Provider.of<AppProvider>(context).isDark ? 1 : 0.2,
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
                      opacity:
                          Provider.of<AppProvider>(context).isDark ? 1 : 0.2,
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
                      opacity:
                          Provider.of<AppProvider>(context).isDark ? 1 : 0.2,
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
            // UserAccountsDrawerHeader(
            //     currentAccountPicture: Expanded(
            //       child: Image.network(
            //         Provider.of<AppProvider>(context).user.image!,

            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     accountName:
            //         Text(Provider.of<AppProvider>(context).user.first_name!),
            //     accountEmail:
            //         Text(Provider.of<AppProvider>(context).user.email!))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        elevation: 1.5,
        backgroundColor: Provider.of<AppProvider>(context).isDark
            ? ((Provider.of<AppProvider>(context).getBarIndex() == 0)
                ? Colors.black
                : Colors.black)
            : Colors.white,
        currentIndex: Provider.of<AppProvider>(context).homeScreenIndex,
        onTap: (value) {
          Provider.of<AppProvider>(context, listen: false)
              .updateBarIndex(value);
        },
        items: [
          BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.home,
                color: (Provider.of<AppProvider>(context).getBarIndex() == 0)
                    ? Colors.blue
                    : (Provider.of<AppProvider>(context).isDark
                        ? Colors.white
                        : Colors.black),
                size: 20.w,
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.search_sharp,
              color: (Provider.of<AppProvider>(context).getBarIndex() == 1)
                  ? Colors.blue
                  : (Provider.of<AppProvider>(context).isDark
                      ? Colors.white
                      : Colors.black),
              size: 20.w,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.person,
              color: (Provider.of<AppProvider>(context).getBarIndex() == 2)
                  ? Colors.blue
                  : (Provider.of<AppProvider>(context).isDark
                      ? Colors.white
                      : Colors.black),
              size: 20.w,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Provider.of<AppProvider>(context).isDark
            ? Colors.black
            : Colors.white,
        elevation: 0,
        actions: [
          Provider.of<AppProvider>(context).getBarIndex() == 1
              ? IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: SearchWidget());
                  },
                  icon: Icon(
                    Icons.search,
                    color: Provider.of<AppProvider>(context).isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                )
              : Padding(padding: EdgeInsets.zero),
          IconButton(
              onPressed: (() {
                Provider.of<AppProvider>(context, listen: false)
                    .setLocaleFromButton();
                context.setLocale(
                    Provider.of<AppProvider>(context, listen: false)
                        .getLocale());
              }),
              icon: Icon(
                size: 30.w,
                Icons.language,
                color: Colors.blue,
              )),
        ],
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.menu,
              size: 30.w,
              color: Provider.of<AppProvider>(context).isDark
                  ? Colors.blue
                  : Colors.black,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      body: screens[Provider.of<AppProvider>(context).getBarIndex()],
    );
  }
}
