import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        ListTile(
          title: Text("Account_Information".tr()),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
          title: Text("Edit_Information".tr()),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.of(context).pushNamed("update_user_page");
          },
        ),
        ListTile(
          title: Text("History".tr()),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
          title: Text("Trips you liked".tr()),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.of(context).pushNamed("FilteredTripScreen");
          },
        ),
        SizedBox(
          height: 30.h,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("LogIn");
            },
            child: Text("Log_Out".tr()))
      ]),
    );
  }
}
