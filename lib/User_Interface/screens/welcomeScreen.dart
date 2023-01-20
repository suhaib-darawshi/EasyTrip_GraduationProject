import 'package:demo/App_Router/App_Router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
      body: Consumer<AppProvider>(builder: (context, provider, c) {
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
                  height: MediaQuery.of(context).size.height / 4,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Welcome to",
                style: TextStyle(fontSize: 35.w),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Easy Trip",
                style: TextStyle(fontSize: 28.w, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 50.h,
                child: ElevatedButton(
                    style: TextButton.styleFrom(shape: StadiumBorder()),
                    onPressed: () {
                      provider.asCompany = false;
                      AppRouter.router.pushReplace("LogIn");
                    },
                    child: Text(
                      "Sign In as User",
                      style: TextStyle(fontSize: 18.w),
                    )),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 50.h,
                child: ElevatedButton(
                    style: TextButton.styleFrom(shape: StadiumBorder()),
                    onPressed: () {
                      provider.asCompany = true;
                      AppRouter.router.pushReplace("LogIn");
                    },
                    child: Text(
                      "Sign In as Company",
                      style: TextStyle(fontSize: 18.w),
                    )),
              )
            ],
          ),
        );
      }),
    );
  }
}
