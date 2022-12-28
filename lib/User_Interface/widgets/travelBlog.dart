import 'package:demo/User_Interface/screens/DetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';
import '../../models/trip.dart';
import '../../provider/app_provider.dart';

class TravelBlog extends StatelessWidget {
  final pageController = PageController(viewportFraction: 0.9);
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: Provider.of<AppProvider>(context).defaultTrips.length,
      itemBuilder: (context, index) {
        Trip t = Provider.of<AppProvider>(context, listen: false)
            .defaultTrips[index];
        return InkWell(
          onTap: () async {
             await Provider.of<AppProvider>(context, listen: false)
                .setCurrentTrip(t);
            AppRouter.router.push("DetailPage");
          },
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20.h, right: 20.w, top: 10.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    t.url,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ),
              Positioned(
                bottom: 80.h,
                left: 15.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        t.location,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.h,
                            color: Colors.white),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        t.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.h,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 30.w,
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(30.h),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30.h,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
