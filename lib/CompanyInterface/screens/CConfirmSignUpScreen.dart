import 'package:demo/provider/CompanyProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';
import '../../User_Interface/widgets/CustomFormField.dart';
import '../../provider/app_provider.dart';

class CCofirmSignUpScreen extends StatelessWidget {
  const CCofirmSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(builder: (context, provider, c) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: (() {
                  provider.setLocaleFromButton();
                  context.setLocale(provider.getLocale());
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
          backgroundColor: provider.isDark ? Colors.black : Colors.white,
          elevation: 0,
        ),
        body: Form(
          key: provider.confirmPageKey,
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Text('check your Email, we sent you a verification key'),
              SizedBox(
                height: 30.h,
              ),
              Text('Please Enter your key here:'),
              CustomTextField(
                  validation: provider.verifValidation,
                  label: '6-digit key',
                  controller: provider.authKeyController),
              ElevatedButton(
                  onPressed: () async {
                    bool x = await provider.createAccount();
                    if (x) {
                      AppRouter.router.pushReplace('companyHomePage');
                    }
                  },
                  child: Text('Check'.tr()))
            ],
          ),
        ),
        backgroundColor: provider.isDark
          ? Colors.black
          : Colors.white,
      );
    });
  }
}
