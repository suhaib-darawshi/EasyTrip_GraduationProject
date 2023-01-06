import 'package:demo/provider/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';
import '../../models/trip.dart';
import '../widgets/CustomTripWidget.dart';

class BookedMarkedScreen extends StatelessWidget {
  const BookedMarkedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, x) {
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
            icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: provider.isDark ? Colors.black : Colors.grey.shade100,
        body: ListView.separated(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
          itemCount: provider.bookedTrips.length,
          itemBuilder: (context, index) {
            Trip t = provider.bookedTrips[index];
            return InkWell(
                onTap: () {
                  provider.setCurrentTrip(t);
                  AppRouter.router.push("DetailPage");
                },
                child: CustomTripWidget(t));
          },
          separatorBuilder: (context, index) => SizedBox(
            height: 15.h,
          ),
        ),
      );
    });
  }
}
