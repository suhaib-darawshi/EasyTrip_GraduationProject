import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/provider/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../widgets/AlertDialog.dart';
import '../widgets/CustomFormField.dart';

class LoginScreen extends StatelessWidget {
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
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  
                  height: MediaQuery.of(context).size.height/4,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/imgs/demologo.PNG',
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/3,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomTextField(
                    icon: const Icon(Icons.email),
                        validation: provider.emailValidation,
                        label: 'Email',
                        controller: provider.emailController),
                ),
                  //  SizedBox(
                  //   height: 20.h,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomTextField(
                      icon: const Icon(Icons.lock_open_sharp),
                        validation: provider.passwordValidation,
                        textInputType: TextInputType.emailAddress,
                        isPassword: true,
                        label: 'password',
                        controller: provider.passwordController),
                  ),
                Container(
                  width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 8,
                    ),
                  child: TextButton(
                        style: TextButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed:  () async {
                        String resp = await provider.logIn();
                        if (resp == "ACCESSED") {
                          AppRouter.router.pushReplace("HomeScreen");
                        } else {
                          provider.clearTextFields();
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertD(resp);
                              });
                        }
                      },
                        child:  Text(
                          "Sign_in".tr(),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                ),
                SizedBox(height: 30.h,),
                // ElevatedButton(
                //     onPressed: () async {
                //       String resp = await provider.logIn();
                //       if (resp == "ACCESSED") {
                //         Navigator.of(context).pushReplacementNamed("HomeScreen");
                //       } else {
                //         provider.clearTextFields();
                //         showDialog(
                //             context: context,
                //             builder: (context) {
                //               return AlertD(resp);
                //             });
                //       }
                //     },
                //     child: Text("Sign_in".tr())),
                Row(
                  children: [
                    Text("Dont_have_an_account_?".tr(),style: TextStyle(fontSize: 22),),
                    SizedBox(
                      width: 20.w,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          AppRouter.router.push("sign_up");
                        },
                        child: Text("Sign_Up".tr()))
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
