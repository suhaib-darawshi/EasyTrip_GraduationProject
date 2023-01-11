import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/User_Interface/widgets/CustomFormField.dart';
import 'package:demo/provider/AdminProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AdminSignIn extends StatelessWidget {
  const AdminSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, x) {
      return Scaffold(
        appBar: AppBar(),
        
        body: Center(
          child: Form(
            key: provider.signinKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 700.w,
                child: CustomTextField(
                  validation: provider.emailValidation,
                  label: "Email".tr(),
                  controller: provider.emailController,
                  icon: Icon(
                    Icons.email,
                    color: Colors.blue,
                  ),
                ),
              ),
              Container(
                width: 700.w,
                child: CustomTextField(
                  validation: provider.passwordValidation,
                  label: "Password".tr(),
                  controller: provider.passwordController,
                  isPassword: true,
                  icon: Icon(
                    Icons.password,
                    color: Colors.blue,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  String res = await provider.login();
                  if (res.length > 25) {
                    AppRouter.router.pushReplace('AdminHomeScreen');
                  } else if (res.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Wrong Information'.tr()),
                          content: Text(res),
                        );
                      },
                    );
                  }
                },
                child: Text("Sign_in".tr()),
              ),
            ]),
          ),
        ),
      );
    });
  }
}
