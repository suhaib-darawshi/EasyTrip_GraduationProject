import 'package:demo/provider/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../models/trip.dart';

class DetailPage extends StatelessWidget {
  late Trip trip;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      trip = Provider.of<AppProvider>(context, listen: false).getCurrentTrip();
      return Scaffold(
        backgroundColor: Provider.of<AppProvider>(context).isDark
            ? Colors.black
            : Colors.white,
        body: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  trip.url,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      right: 15,
                      left: 15),
                  child: SizedBox(
                    height: kToolbarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.arrow_back_ios,
                                color: (Provider.of<AppProvider>(context).isDark
                                    ? Colors.black
                                    : Colors.white))),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 25,
                    left: 20,
                    child: Text(
                      trip.name,
                      style: TextStyle(
                          fontSize: 30.h,
                          fontWeight: FontWeight.bold,
                          color: Provider.of<AppProvider>(context).isDark
                              ? Colors.black
                              : Colors.white),
                    )),
                // Positioned(
                //     bottom: 20,
                //     right: 20,
                //     child: ElevatedButton(
                //       onPressed: () {},
                //       child: Text("BookMark".tr()),
                //     ))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        child: (Provider.of<AppProvider>(context)
                                .currentTrip
                                .isLiked)
                            ? Icon(Icons.favorite,
                                size: 50.h, color: Colors.red)
                            : Icon(Icons.favorite_border,
                                size: 50.h,
                                color: (Provider.of<AppProvider>(context).isDark
                                    ? Colors.white
                                    : Colors.black)),
                        onTap: () {
                          Provider.of<AppProvider>(context, listen: false)
                              .likeTrip(trip);
                        },
                      ),
                      Text(Provider.of<AppProvider>(context)
                          .currentTrip
                          .liked_count
                          .toString())
                    ],
                  ),
                  InkWell(
                    child: Icon(
                      Icons.bookmark_border,
                      size: 50.h,
                      color: Provider.of<AppProvider>(context).isDark
                          ? Colors.white
                          : Colors.black,
                    ),
                    onTap: () {},
                  )
                ],
              ),
            ),
            Container(
              color: Provider.of<AppProvider>(context).isDark
                  ? Colors.grey.shade900
                  : Colors.grey.shade300,
              height: kToolbarHeight,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Information".tr(),
                      style: TextStyle(fontSize: 18.w),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Opacity(
                          opacity: 0.7,
                          child: Text(
                            "E-mail",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Text(
                            trip.company.email,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Opacity(
                          opacity: 0.7,
                          child: Text(
                            "Phone :",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Text(
                            trip.company.phone,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Opacity(
                          opacity: 0.7,
                          child: Text(
                            "Company Location :",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Text(
                            trip.company.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(
                            Icons.facebook,
                            size: 45.h,
                            color: Colors.blue.shade700,
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(
                            Icons.snapchat,
                            size: 45.h,
                            color: Colors.yellowAccent,
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(
                            Icons.whatsapp,
                            size: 45.h,
                            color: Colors.green,
                          )),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              color: Provider.of<AppProvider>(context).isDark
                  ? Colors.grey.shade900
                  : Colors.grey.shade300,
              height: 40,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Description".tr(),
                      style: TextStyle(fontSize: 18.w),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                trip.description,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
