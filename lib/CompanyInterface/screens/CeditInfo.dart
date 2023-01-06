import 'package:demo/provider/CompanyProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../User_Interface/widgets/CustomFormField.dart';

class CompanyEditInformationScreen extends StatelessWidget {
  const CompanyEditInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(builder: (context, provider, c) {
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
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.blue,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
        backgroundColor: provider.isDark ? Colors.black : Colors.white,
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Container(
                width: double.infinity,
                height: 150.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(provider.user.logo),
                      fit: BoxFit.contain),
                  shape: BoxShape.rectangle,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  provider.pickLogo();
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
                  label: "Company_Name".tr(),
                  controller: provider.CompanyNameController),
              CustomTextField(
                validation: provider.requiredValidation,
                label: "Address".tr(),
                controller: provider.CompanyAddressController,
                icon: Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 35.h,
                ),
              ),
              CustomTextField(
                validation: provider.emailValidation,
                label: "Company Email".tr(),
                controller: provider.CompanyEmailController,
                icon: Icon(
                  Icons.email,
                  color: Colors.blue,
                  size: 35.h,
                ),
              ),
              CustomTextField(
                validation: provider.phoneValidation,
                label: "password".tr(),
                controller: provider.CompanyPasswordController,
                isPassword: true,
                icon: Icon(
                  Icons.password,
                  color: Colors.blue,
                  size: 35.h,
                ),
              ),
              CustomTextField(
                validation: provider.passwordValidation,
                label: "Phone_Number".tr(),
                controller: provider.CompanyPhoneController,
                icon: Icon(
                  Icons.phone,
                  color: Colors.blue,
                  size: 35.h,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await provider.updateInfo();
                  },
                  child: Text("Update".tr()))
            ])),
      );
    });
  }
}
