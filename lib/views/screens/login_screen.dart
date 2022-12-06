import 'package:demo/provider/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../widgets/AlertDialog.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (() {
                if (context.locale == Locale('en')) {
                  context.setLocale(Locale('ar'));
                } else {
                  context.setLocale(Locale('en'));
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
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300.w,
                    height: MediaQuery.of(context).size.height/2,
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
                        icon: Icon(
                          Icons.person_rounded,
                          color: Colors.black,
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
                          color: Colors.black,
                        ),
                        labelText: "Password".tr(),
                      ),
                      controller: provider.passwordController,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        String resp = await provider.logIn();
                        if (resp == "ACCESSED") {
                          Navigator.of(context).pushReplacementNamed("Home");
                        } else {
                          provider.clearTextFields();
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertD(resp);
                              });
                        }
                      },
                      child: Text("Sign_in".tr())),
                  Row(
                    children: [
                      Text("Dont_have_an_account_?".tr()),
                      SizedBox(
                        width: 20.w,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("sign_up");
                          },
                          child: Text("Sign_Up".tr()))
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
