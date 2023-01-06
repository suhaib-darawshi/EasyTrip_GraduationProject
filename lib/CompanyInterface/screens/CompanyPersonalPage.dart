import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/CompanyInterface/widgets/CAvatar.dart';
import 'package:demo/provider/CompanyProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CPersonalPage extends StatelessWidget {
  const CPersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(builder: (context, provider, c) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: provider.isDark ? Colors.black : Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: provider.isDark ? Colors.white : Colors.black,
            ),
            onPressed: () => AppRouter.router.pop(),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  provider.setLocaleFromButton();
                  context.setLocale(provider.getLocale());
                },
                icon: Icon(
                  Icons.language,
                  color: Colors.blue,
                ))
          ],
        ),
        body: Column(
          children: [
            CompanyAvatar(),
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: provider.isDark
                      ? Colors.grey.shade900
                      : Colors.grey.shade300,
                  height: kToolbarHeight,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Statistics".tr(),
                          style: TextStyle(fontSize: 18.w),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )))
          ],
        ),
      );
    });
  }
}
