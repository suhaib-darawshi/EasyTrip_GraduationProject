import 'package:demo/provider/CompanyProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';

class CompanyAvatar extends StatelessWidget {
  const CompanyAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(builder: (context, provider, c) {
      return Container(
        width: double.infinity,
        color: provider.isDark ? Colors.black87 : Colors.white,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: double.infinity,
                height: 180.h,

                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(provider.user.logo),
                      fit: BoxFit.contain),
                  shape: BoxShape.rectangle,
                ),
                // child: CircleAvatar(
                //   radius: 40.h,
                //   child: Image.network(
                //     Provider.of<AppProvider>(context).user.image!,
                //   ),
                // ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                provider.user.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: provider.isDark ? Colors.white : Colors.black),
              ),
              Opacity(
                opacity: 0.7,
                child: Text(
                  provider.user.email,
                  style: TextStyle(
                      fontSize: 18.w,
                      color: provider.isDark ? Colors.white : Colors.black),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 155.w,
                height: 45.h,
                child: ElevatedButton(
                  onPressed: () {
                    provider.fillControllers();
                    AppRouter.router.push("CompanyEditInformationScreen");
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    shape: StadiumBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Edit_Profile".tr(),
                        style: TextStyle(fontSize: 16.w, color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: provider.isDark ? Colors.white : Colors.black,
              )
            ],
          ),
        ),
      );
    });
  }
}
