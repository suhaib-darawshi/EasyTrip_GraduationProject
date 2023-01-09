import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/provider/AdminProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../models/trip.dart';

class TripItem extends StatelessWidget {
  final int trip;
  const TripItem({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, x) {
      return Container(
        height: 100.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(provider.trips[trip].id)),
            Expanded(child: Text("${provider.trips[trip].name}")),
            Expanded(child: Text(provider.trips[trip].location)),
            Expanded(child: Text(provider.trips[trip].price)),
            Expanded(child: Text(provider.trips[trip].companyid.name)),
            Expanded(child: Text(provider.trips[trip].rate.toString())),
            Expanded(
              child: ElevatedButton(
                style: TextButton.styleFrom(backgroundColor: Colors.red),
                child: Text("Remove"),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: Text("WARNING"),
                          content: Text("Are you sure you want to delete it ?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  AppRouter.router.pop();
                                },
                                child: Text("no")),
                            TextButton(
                                onPressed: () async {
                                  await provider
                                      .deleteTrip(provider.trips[trip]);
                                  AppRouter.router.pop();
                                },
                                child: Text("yes")),
                          ],
                        );
                      }));
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
