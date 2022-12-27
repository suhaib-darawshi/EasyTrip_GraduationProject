import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/provider/CompanyProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../models/trip.dart';
import '../../provider/app_provider.dart';

class CompanyViewTripWidget extends StatelessWidget {
  final Trip trip;
  const CompanyViewTripWidget(this.trip);

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(builder: (context, provider, c) {
      return Card(
        color: provider.isDark ? Colors.grey.shade900 : Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.16,
          margin: EdgeInsets.all(8.h),
          width: double.infinity,
          child: Row(
            children: [
              Image.network(
                trip.url,
                width: MediaQuery.of(context).size.width / 4,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width - 150.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          trip.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.w,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "By: ${trip.company.name}",
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue.shade700,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "8.9",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      const Text(
                        "Fabulous",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 150.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(trip.location)
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            provider.setCurrentTrip(trip);
                            AppRouter.router.push('CEditTripScreen');
                          },
                          child: Text(
                            'View Details'.tr(),
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
