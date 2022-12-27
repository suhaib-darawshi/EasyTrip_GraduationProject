import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/provider/CompanyProvider.dart';
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
                Provider.of<AppProvider>(context, listen: false)
                    .setLocaleFromButton();
                context.setLocale(
                    Provider.of<AppProvider>(context, listen: false)
                        .getLocale());
              }),
              icon: const Icon(
                Icons.language,
                color: Colors.blue,
              ))
        ],
        backgroundColor: Provider.of<AppProvider>(context).isDark
            ? Colors.black
            : Colors.white,
        elevation: 0,
      ),
      backgroundColor: Provider.of<AppProvider>(context).isDark
          ? Colors.black
          : Colors.white,
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  alignment: Alignment.center,
                  child: Image.asset(
                    Provider.of<AppProvider>(context).isDark
                        ? 'assets/imgs/demologodark.PNG'
                        : 'assets/imgs/demologo.PNG',
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomTextField(
                      icon: const Icon(Icons.email),
                      validation: provider.emailValidation,
                      label: 'Email',
                      controller: provider.asCompany
                          ? Provider.of<CompanyProvider>(context)
                              .CompanyEmailController
                          : provider.emailController),
                ),
                //  SizedBox(
                //   height: 20.h,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomTextField(
                      icon: const Icon(Icons.lock_open_sharp),
                      validation: provider.passwordValidation,
                      textInputType: TextInputType.emailAddress,
                      isPassword: true,
                      label: 'password',
                      controller: provider.asCompany
                          ? Provider.of<CompanyProvider>(context)
                              .CompanyPasswordController
                          : provider.passwordController),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 8,
                  ),
                  decoration: BoxDecoration(
                      color: Provider.of<AppProvider>(context).isDark
                          ? Colors.blue
                          : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 1, color: Colors.blue)),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Provider.of<AppProvider>(context).isDark
                          ? Colors.blue
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
                      if (!provider.asCompany) {
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
                      } else {
                        String resp = await Provider.of<CompanyProvider>(
                                context,
                                listen: false)
                            .signIn();
                        if (resp == "ACCESSED") {
                          AppRouter.router.pushReplace("companyHomePage");
                        } else {
                          provider.clearTextFields();
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertD(resp);
                              });
                        }
                      }
                    },
                    child: Text(
                      "Sign_in".tr(),
                      style: TextStyle(
                        fontSize: 22,
                        color: Provider.of<AppProvider>(context).isDark
                            ? Colors.white
                            : Colors.blue,
                        backgroundColor:
                            Provider.of<AppProvider>(context).isDark
                                ? Colors.blue
                                : Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        "Dont_have_an_account_?".tr(),
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    ElevatedButton(
                        style: TextButton.styleFrom(
                            backgroundColor:
                                Provider.of<AppProvider>(context).isDark
                                    ? Colors.black
                                    : Colors.white,
                            elevation: 0),
                        onPressed: () {
                          provider.asCompany
                              ? AppRouter.router.push("CompanySignUp")
                              : AppRouter.router.push("sign_up");
                        },
                        child: Text(
                          "Sign_Up".tr(),
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 23.w,
                            backgroundColor:
                                Provider.of<AppProvider>(context).isDark
                                    ? Colors.black
                                    : Colors.white,
                          ),
                        ))
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
