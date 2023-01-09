import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/adminInterface/widgets/CompanyTable.dart';
import 'package:demo/adminInterface/widgets/TripMenu.dart';
import 'package:demo/adminInterface/widgets/usersTable.dart';
import 'package:demo/provider/AdminProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/ListMenu.dart';

class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({super.key});
  List<Widget> pages = [TripMenu(),UsersTable(),CompanyTable()];
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
        appBar: AppBar(),
        body: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 6,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: provider.isDark ? Colors.white : Colors.black)),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: ((context, index) {
                          return ListMenuIrem(
                              name: provider.homePages[index], page: index);
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
            pages[provider.homePageIndex]
          ],
        ),
      );
    });
  }
}
