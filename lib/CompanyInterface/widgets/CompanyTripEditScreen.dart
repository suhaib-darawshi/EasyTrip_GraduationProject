import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/models/trip.dart';
import 'package:demo/provider/CompanyProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CEditTripScreen extends StatelessWidget {
  late Trip trip;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<CompanyProvider>(context).isDark
          ? Colors.black
          : Colors.white,
      body: Consumer<CompanyProvider>(
        builder: (context, provider, child) {
          trip = provider.currentTrip;
          return Column(
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
                                  color: (provider.isDark
                                      ? Colors.white
                                      : Colors.black))),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 40,
                      left: 20,
                      child: Text(
                        trip.name,
                        style: TextStyle(
                            fontSize: 30.h,
                            fontWeight: FontWeight.bold,
                            color:
                                provider.isDark ? Colors.white : Colors.black),
                      )),
                  Positioned(
                      bottom: 5,
                      left: 20,
                      child: Text(
                        '${trip.duration.toString()} ' + 'days'.tr(),
                        style: TextStyle(
                            fontSize: 30.h,
                            fontWeight: FontWeight.bold,
                            color:
                                provider.isDark ? Colors.white : Colors.black),
                      )),
                  Positioned(
                      bottom: 5,
                      right: 20,
                      child: Row(
                        children: [
                          Text(
                            trip.price,
                            style: TextStyle(
                                fontSize: 30.h,
                                fontWeight: FontWeight.bold,
                                color: provider.isDark
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          Icon(
                            Icons.attach_money,
                            size: 30.w,
                            color:
                                provider.isDark ? Colors.white : Colors.black,
                          )
                        ],
                      )),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(
                            color:
                                provider.isDark ? Colors.white : Colors.grey))),
                height: kToolbarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        !provider.currentTrip.approved
                            ? Icon(Icons.lock_outline_sharp,
                                size: 40.h, color: Colors.red)
                            : InkWell(
                                child: (provider.currentTrip.available)
                                    ? Icon(Icons.lock_open_sharp,
                                        size: 40.h,
                                        color: (provider.isDark
                                            ? Colors.white
                                            : Colors.black))
                                    : Icon(Icons.lock_outline_sharp,
                                        size: 40.h, color: Colors.red),
                                onTap: () async {
                                  await provider.lockTrip();
                                },
                              ),
                        Text(
                          provider.currentTrip.liked_count.toString(),
                          style: TextStyle(
                              color: provider.isDark
                                  ? Colors.white
                                  : Colors.black),
                        )
                      ],
                    ),
                    InkWell(
                      child: Icon(
                        Icons.edit,
                        size: 40.h,
                        color: provider.isDark ? Colors.white : Colors.black,
                      ),
                      onTap: () {
                        provider.fillForEdit();
                        AppRouter.router.push('EditTripScreen');
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
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
                                "Information".tr(),
                                style: TextStyle(
                                    fontSize: 18.w,
                                    color: provider.isDark
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: provider.isDark ? Colors.white : Colors.black,
                        height: 1,
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
                                      "E-mail :".tr(),
                                      style: TextStyle(
                                          fontSize: 18.w,
                                          color: provider.isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      trip.companyid.email,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: provider.isDark
                                              ? Colors.white
                                              : Colors.black),
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
                                      "Phone :".tr(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: provider.isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      trip.companyid.phone,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: provider.isDark
                                              ? Colors.white
                                              : Colors.black),
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
                                      "Company Location :".tr(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: provider.isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      trip.companyid.name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: provider.isDark
                                              ? Colors.white
                                              : Colors.black),
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
                      Container(
                        width: double.infinity,
                        height: kToolbarHeight,
                        color: provider.isDark
                            ? Colors.grey.shade900
                            : Colors.grey.shade300,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Trip Information".tr(),
                                style: TextStyle(
                                    fontSize: 18.w,
                                    color: provider.isDark
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Opacity(
                                    opacity: 0.7,
                                    child: Text(
                                      "Hotel :".tr(),
                                      style: TextStyle(
                                          fontSize: 18.w,
                                          color: provider.isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          trip.hotel,
                                          style: TextStyle(
                                              color: provider.isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 20.w,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              trip.hotelRank[0],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: provider.isDark
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 35.w,
                                            )
                                          ],
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Opacity(
                                    opacity: 0.7,
                                    child: Text(
                                      "Flight Company:",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: provider.isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      trip.flight,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: provider.isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Opacity(
                                    opacity: 0.7,
                                    child: Text(
                                      "From :".tr(),
                                      style: TextStyle(
                                          fontSize: 18.w,
                                          color: provider.isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      trip.begin.toString(),
                                      style: TextStyle(
                                          color: provider.isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ))
                              ],
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Opacity(
                                    opacity: 0.7,
                                    child: Text(
                                      "Until :",
                                      style: TextStyle(
                                          fontSize: 18.w,
                                          color: provider.isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      trip.end.toString(),
                                      style: TextStyle(
                                          color: provider.isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ))
                              ],
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Opacity(
                                    opacity: 0.7,
                                    child: Text(
                                      "Food Reserved:".tr(),
                                      style: TextStyle(
                                          fontSize: 18.w,
                                          color: provider.isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        provider.currentTrip.foodDeserved
                                            ? Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size: 35.w,
                                              )
                                            : Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                                size: 35.w,
                                              ),
                                      ],
                                    ))
                              ],
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Opacity(
                                    opacity: 0.7,
                                    child: Text(
                                      "Car Provided:".tr(),
                                      style: TextStyle(
                                          fontSize: 18.w,
                                          color: provider.isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        provider.currentTrip.carProvided
                                            ? Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size: 35.w,
                                              )
                                            : Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                                size: 35.w,
                                              ),
                                      ],
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
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
                                "Description".tr(),
                                style: TextStyle(
                                    fontSize: 18.w,
                                    color: provider.isDark
                                        ? Colors.white
                                        : Colors.black),
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
                              color: provider.isDark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
