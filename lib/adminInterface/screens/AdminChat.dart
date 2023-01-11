import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/adminInterface/widgets/MessageWidget.dart';
import 'package:demo/adminInterface/widgets/UserWidget.dart';
import 'package:demo/provider/AdminProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../User_Interface/widgets/MessageWidget.dart';

class AdminChatScreen extends StatelessWidget {
  const AdminChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, x) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                AppRouter.router.pushReplace('AdminHomeScreen');
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 5,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 5)),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                    itemCount: provider.users.length,
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.black,
                        height: 3.h,
                      );
                    },
                    itemBuilder: (context, index) {
                      return UserWidget(user: provider.users[index]);
                    },
                  ))
                ],
              ),
            ),
            Container(
              color: provider.isDark ? Colors.black : Colors.white38,
              width: MediaQuery.of(context).size.width / 1.3,
              child: Column(
                children: [
                  Container(
                    height: 40.h,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Text(
                        provider.users[provider.selectedUser].first_name!,
                        style: TextStyle(fontSize: 25.w, color: Colors.black87),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                      child: ListView.separated(
                    itemCount:
                        provider.users[provider.selectedUser].chat.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 5.h,
                      );
                    },
                    itemBuilder: (context, index) {
                      return AdminMessageWidget(
                          message: provider
                              .users[provider.selectedUser].chat[index]);
                    },
                  )),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.h,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 32,
                          color: Color(0xFF087949).withOpacity(0.08),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.abc,
                                    color: Colors.blue.withOpacity(0.64),
                                  ),
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: TextField(
                                      controller: provider.messageController,
                                      decoration: InputDecoration(
                                        hintText: "Type message".tr(),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await provider.sendMessage();
                                    },
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.blue.withOpacity(0.64),
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
