import 'package:demo/App_Router/App_Router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/serviceWidget.dart';

class PersonalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        CustomListTile(
          text: "Privacy".tr(),
          icon: Icon(Icons.privacy_tip),
          function: () {
            AppRouter.router.push("AccountInformation");
          },
        ),
        CustomListTile(
          text: "Edit_Information".tr(),
          icon: const Icon(Icons.perm_contact_cal_sharp),
          function: () {
            AppRouter.router.push("update_user_page");
          },
        ),
        CustomListTile(
          text: "History".tr(),
          icon: const Icon(Icons.history),
          function: () {},
        ),
        CustomListTile(
          text: "Trips you liked".tr(),
          icon: const Icon(Icons.favorite),
          function: () {
            AppRouter.router.push("FilteredTripScreen");
          },
        ),
        Spacer(),
        CustomListTile(
          text: "Log_Out".tr(),
          icon: Icon(Icons.logout),
          function: () {
            AppRouter.router.pushReplace("LogIn");
          },
        ),
      ]),
    );
  }
}
