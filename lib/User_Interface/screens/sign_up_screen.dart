import 'package:demo/provider/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
              icon: const Icon(Icons.language))
        ],
        backgroundColor: Colors.black,
      ),
      body: Consumer<AppProvider>(builder: (context, provider, x) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 300.w,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/imgs/demologo.PNG',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.abc,
                      color: Colors.black,
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
                    icon: const Icon(
                      Icons.abc,
                      color: Colors.black,
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
                    icon: const Icon(
                      Icons.email,
                      color: Colors.black,
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
                    icon: const Icon(
                      Icons.lock_open,
                      color: Colors.black,
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
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.black,
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
                    Navigator.of(context).pop();
                  },
                  child: Text("Sign_Up".tr()))
            ],
          ),
        );
      }),
    );
  }
}
