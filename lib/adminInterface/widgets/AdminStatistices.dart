import 'dart:developer';

import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/adminInterface/widgets/controlWidget.dart';
import 'package:demo/provider/AdminProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AdminStatistics extends StatelessWidget {
  const AdminStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, x) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Welcome to Admin Panel",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50.w,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    children: [
                      Text(
                        'Suhaib',
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        height: 3,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 133.h,
              ),
              Container(
                height: 224.h,
                child: Row(
                  children: [
                    ControlWidget(
                        icon: Icon(
                          Icons.difference_outlined,
                          size: 70.w,
                          color: Colors.white,
                        ),
                        color: Colors.blue,
                        text: 'Trips',
                        function: () {},
                        numb: provider.trips.length),
                    ControlWidget(
                        icon: Icon(
                          Icons.message,
                          size: 70.w,
                          color: Colors.white,
                        ),
                        color: Colors.green,
                        text: 'Chat',
                        function: () {
                          AppRouter.router.pushReplace('AdminChatScreen');
                        },
                        numb: 3),
                    ControlWidget(
                        icon: Icon(
                          Icons.groups_rounded,
                          size: 70.w,
                          color: Colors.white,
                        ),
                        color: Colors.orange,
                        text: 'Users',
                        function: () {},
                        numb: provider.users.length),
                    ControlWidget(
                        icon: Icon(
                          Icons.home_work_outlined,
                          size: 70.w,
                          color: Colors.white,
                        ),
                        color: Colors.red,
                        text: 'Companies',
                        function: () {},
                        numb: provider.companies.length)
                  ],
                ),
              )
            ],
          ));
    });
  }
}
