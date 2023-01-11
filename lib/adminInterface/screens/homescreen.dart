import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/adminInterface/widgets/CompanyTable.dart';
import 'package:demo/adminInterface/widgets/TripMenu.dart';
import 'package:demo/adminInterface/widgets/usersTable.dart';
import 'package:demo/provider/AdminProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../widgets/AdminStatistices.dart';
import '../widgets/ListMenu.dart';

class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({super.key});
  List<Widget> pages = [
    TripMenu(),
    UsersTable(),
    CompanyTable(),
    AdminStatistics()
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, x) {
      return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    AppRouter.router.pushReplace('AdminSignIn');
                  },
                  child: Text("Log_Out".tr()))
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Easy Trip : Admin page"),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 6,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: Colors.black
                  // border: Border.all(
                  //     color: provider.isDark ? Colors.white : Colors.black)
                  ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: ((context, index) {
                          return ListMenuIrem(
                            name: provider.homePages[index],
                            page: index,
                            icon: provider.icons[index],
                          );
                        }),
                        separatorBuilder: ((context, index) {
                          return Divider(
                            color:
                                provider.isDark ? Colors.white : Colors.black,
                          );
                        }),
                        itemCount: provider.homePages.length),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 270.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 100.w,
                        ),
                        pages[provider.homePageIndex],
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
