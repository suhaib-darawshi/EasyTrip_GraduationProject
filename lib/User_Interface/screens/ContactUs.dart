import 'package:demo/User_Interface/widgets/MessageWidget.dart';
import 'package:demo/provider/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, c) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: provider.isDark ? Colors.black : Colors.white,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: (() {
                  provider.setLocaleFromButton();
                  context.setLocale(provider.getLocale());
                }),
                icon: const Icon(
                  Icons.language,
                  color: Colors.blue,
                )),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("Contact Us".tr()),
        ),
        body: Container(
          color: provider.isDark ? Colors.black : Colors.white38,
          child: Column(
            children: [
              Expanded(
                  child: ListView.separated(
                itemCount: provider.user.chat.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 5.h,
                  );
                },
                itemBuilder: (context, index) {
                  return MessageWidget(message: provider.user.chat[index]);
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
      );
    });
  }
}
