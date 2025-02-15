import 'dart:developer';

import 'package:demo/provider/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay/pay.dart';
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
        body: Consumer<AppProvider>(builder: (context, provider, c) {
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
                                  size: 35.w,
                                  color: (provider.isDark
                                      ? Colors.black
                                      : Colors.white))),
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
                                provider.isDark ? Colors.black : Colors.white),
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
                                provider.isDark ? Colors.black : Colors.white),
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
                                    ? Colors.black
                                    : Colors.white),
                          ),
                          Icon(
                            Icons.attach_money,
                            size: 30.w,
                            color:
                                provider.isDark ? Colors.black : Colors.white,
                          )
                        ],
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              child: (provider.currentTrip.isLiked)
                                  ? Icon(Icons.favorite,
                                      size: 50.h, color: Colors.red)
                                  : Icon(Icons.favorite_border,
                                      size: 50.h,
                                      color: (provider.isDark
                                          ? Colors.white
                                          : Colors.black)),
                              onTap: () {
                                provider.like(trip);
                              },
                            ),
                            Text(provider.currentTrip.liked_count.toString())
                          ],
                        ),
                        GooglePayButton(
                          paymentConfigurationAsset:
                              'json/default_payment_profile_google_pay.json',
                          paymentItems: [
                            PaymentItem(
                              label: 'Total',
                              amount: provider.currentTrip.price,
                              status: PaymentItemStatus.final_price,
                            )
                          ],
                          type: GooglePayButtonType.book,
                          margin: const EdgeInsets.only(top: 15.0),
                          onPaymentResult: (result) {},
                          loadingIndicator: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        provider.currentTrip.available
                            ? InkWell(
                                child: provider.currentTrip.isBooked
                                    ? Icon(
                                        Icons.bookmark,
                                        size: 50.h,
                                        color: provider.isDark
                                            ? Colors.white
                                            : Colors.black,
                                      )
                                    : Icon(
                                        Icons.bookmark_border,
                                        size: 50.h,
                                        color: provider.isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                onTap: () async {
                                  await provider.bookTrip();
                                },
                              )
                            : Icon(
                                Icons.lock,
                                size: 50.w,
                                color: Colors.red,
                              )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
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
                                      "E-mail :".tr(),
                                      style: TextStyle(
                                        fontSize: 18.w,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      trip.companyid.email,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
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
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      trip.companyid.phone,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
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
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      trip.companyid.name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
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
                                style: TextStyle(fontSize: 18.w),
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
                                      ),
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
                                                  fontWeight: FontWeight.bold),
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
                                      "Flight Company:".tr(),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      trip.flight,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
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
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 3, child: Text(trip.begin.toString()))
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
                                      "Until :".tr(),
                                      style: TextStyle(
                                        fontSize: 18.w,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 3, child: Text(trip.end.toString()))
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
                                      ),
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
                                      ),
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
                      Divider(
                        color: provider.isDark ? Colors.white : Colors.black,
                        height: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rate this Trip".tr(),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    provider.changeRate(1);
                                  },
                                  child: Icon(
                                    Icons.star,
                                    color: provider.rate > 0
                                        ? Colors.yellow
                                        : Colors.grey,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    provider.changeRate(2);
                                  },
                                  child: Icon(
                                    Icons.star,
                                    color: provider.rate > 1
                                        ? Colors.yellow
                                        : Colors.grey,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    provider.changeRate(3);
                                  },
                                  child: Icon(
                                    Icons.star,
                                    color: provider.rate > 2
                                        ? Colors.yellow
                                        : Colors.grey,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    provider.changeRate(4);
                                  },
                                  child: Icon(
                                    Icons.star,
                                    color: provider.rate > 3
                                        ? Colors.yellow
                                        : Colors.grey,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    provider.changeRate(5);
                                  },
                                  child: Icon(
                                    Icons.star,
                                    color: provider.rate > 4
                                        ? Colors.yellow
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: ElevatedButton(
                                onPressed: () async {
                                  await provider.rateTrip();
                                },
                                child: Text("submit".tr())),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}
