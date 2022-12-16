import 'package:demo/provider/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (() {
                if (context.locale == const Locale('en')) {
                  context.setLocale(const Locale('ar'));
                } else {
                  context.setLocale(const Locale('en'));
                }
              }),
              icon: const Icon(
                Icons.language,
                color: Colors.blue,
              ))
        ],
        leading: IconButton(
            onPressed: () => AppRouter.router.pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            )),
        backgroundColor: Provider.of<AppProvider>(context).isDark
            ? Colors.black
            : Colors.white,
        elevation: 0,
      ),
      body: Consumer<AppProvider>(builder: (context, provider, x) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 300.w,
                alignment: Alignment.center,
                child: Image.asset(
                  Provider.of<AppProvider>(context).isDark
                      ? 'assets/imgs/demologodark.PNG'
                      : 'assets/imgs/demologo.PNG',
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: 35.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.abc,
                      color: provider.isDark ? Colors.white : Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelText: "First_Name".tr(),
                  ),
                  controller: provider.firstnameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.abc,
                      color: provider.isDark ? Colors.white : Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelText: "Last_Name".tr(),
                  ),
                  controller: provider.lastnameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: provider.isDark ? Colors.white : Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelText: "Email".tr(),
                  ),
                  controller: provider.emailController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock_open,
                      color: provider.isDark ? Colors.white : Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelText: "Password".tr(),
                  ),
                  controller: provider.passwordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.phone,
                      color: provider.isDark ? Colors.white : Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelText: "Phone_Number".tr(),
                  ),
                  controller: provider.phoneNumberController,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    provider.signUp();
                  },
                  style: TextButton.styleFrom(
                      backgroundColor:
                          provider.isDark ? Colors.black : Colors.white,
                      elevation: 0),
                  child: Text(
                    "Sign_Up".tr(),
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 23,
                        backgroundColor:
                            provider.isDark ? Colors.black : Colors.white),
                  ))
            ],
          ),
        );
      }),
      backgroundColor: Provider.of<AppProvider>(context).isDark
          ? Colors.black
          : Colors.white,
    );
  }
}
