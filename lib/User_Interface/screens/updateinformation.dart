import 'package:demo/User_Interface/widgets/CustomFormField.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../widgets/Avatar_information.dart';

class UpdateUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Provider.of<AppProvider>(context).isDark
              ? Colors.black
              : Colors.white,
          elevation: 0,
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
                )),
          ],
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      backgroundColor: Provider.of<AppProvider>(context).isDark
          ? Colors.black
          : Colors.white,
      body: Consumer<AppProvider>(builder: (context, provider, x) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120.w,
                height: 120.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(provider.user.image!),
                      fit: BoxFit.cover),
                  shape: BoxShape.circle,
                ),
              ),
              InkWell(
                onTap: () {
                  provider.pickImageForCategory();
                },
                child: Text(
                  "EditPicture".tr(),
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                  validation: provider.requiredValidation,
                  label: "First_Name".tr(),
                  controller: provider.firstnameController),
              CustomTextField(
                  validation: provider.requiredValidation,
                  label: "Last_Name".tr(),
                  controller: provider.lastnameController),
              CustomTextField(
                validation: provider.emailValidation,
                label: "Email".tr(),
                controller: provider.emailController,
                textInputType: TextInputType.emailAddress,
                icon: Icon(
                  Icons.email,
                  color: Colors.blue,
                  size: 35,
                ),
              ),
              CustomTextField(
                validation: provider.passwordValidation,
                label: "Password".tr(),
                controller: provider.passwordController,
                isPassword: true,
                icon: Icon(
                  Icons.lock_open,
                  color: Colors.blue,
                  size: 35,
                ),
              ),
              CustomTextField(
                validation: provider.phoneValidation,
                label: "Phone_Number".tr(),
                controller: provider.phoneNumberController,
                textInputType: TextInputType.phone,
                icon: Icon(
                  Icons.phone,
                  color: Colors.blue,
                  size: 35,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    provider.updateInfo();
                  },
                  child: Text("save_edit".tr()))
            ],
          ),
        );
      }),
    );
  }
}
