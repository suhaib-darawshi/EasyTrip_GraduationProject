import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class UpdateUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
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
      body: Consumer<AppProvider>(builder: (context, provider, x) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/imgs/demologo.PNG',
                  width: MediaQuery.of(context).size.width,
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
                    labelText: "Email".tr(),
                  ),
                  controller: provider.emailController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.lock_open,
                      color: Colors.black,
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
                    labelText: "Phone_Number".tr(),
                  ),
                  controller: provider.phoneNumberController,
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
