import 'dart:developer';

import 'package:demo/provider/AdminProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, x) {
      return InkWell(
        onTap: () {
          provider.setChatUser(provider.users.indexOf(user));
        },
        child: Container(
            height: 100.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(user.image!), fit: BoxFit.cover),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 5 - 80,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.first_name!} ${user.last_name!}',
                          style: TextStyle(
                              fontSize: 30.w, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          user.chat.isEmpty ? '' : user.chat.last.text,
                          style: TextStyle(fontSize: 20.w),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      );
    });
  }
}
