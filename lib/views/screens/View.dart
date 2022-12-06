import 'package:demo/views/widgets/MostPopular.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/travelBlog.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: HomeView(),
  ));
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
            IconButton(
                onPressed: (() {
                  if (context.locale == Locale('en')) {
                    context.setLocale(Locale('ar'));
                  } else {
                    context.setLocale(Locale('en'));
                  }
                }),
                icon: const Icon(Icons.language,color: Colors.blue,))
          ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(left: 15.h),
            child: Text(
              "Travel_Blog".tr(),
              style: TextStyle(fontSize: 36.h),
            ),
          ),
          Expanded(
            child: TravelBlog(),
            flex: 2,
          ),
          Padding(
            padding:  EdgeInsets.all(15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Most_Popular".tr(),
                  style: TextStyle(fontSize: 20.h),
                ),
                Text(
                  "View_All".tr(),
                  style: TextStyle(fontSize: 16.h, color: Colors.deepOrange),
                )
              ],
            ),
          ),
          Expanded(flex: 1, child: MostPopular())
        ],
      ),
    );
  }
}
