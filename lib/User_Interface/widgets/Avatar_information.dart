import 'package:demo/models/user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';
import '../../provider/app_provider.dart';

class AvatarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3.4,
      color: Provider.of<AppProvider>(context).isDark
          ? Colors.black87
          : Colors.white,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: 120.w,
              height: 120.h,

              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        Provider.of<AppProvider>(context).user.image!),
                    fit: BoxFit.cover),
                shape: BoxShape.circle,
              ),
              // child: CircleAvatar(
              //   radius: 40.h,
              //   child: Image.network(
              //     Provider.of<AppProvider>(context).user.image!,
              //   ),
              // ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "${Provider.of<AppProvider>(context).user.first_name} ${Provider.of<AppProvider>(context).user.last_name}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Opacity(
              opacity: 0.7,
              child: Text(
                Provider.of<AppProvider>(context).user.email!,
                style: TextStyle(fontSize: 18.w),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
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
            )
          ],
        ),
      ),
    );
  }
}
