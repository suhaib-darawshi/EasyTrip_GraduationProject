import 'package:demo/provider/app_provider.dart';
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
                                color: Colors.black)),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.favorite,
                      size: 50.h,
                      color: (Provider.of<AppProvider>(context)
                              .currentTrip
                              .isLiked)
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onTap: () {
                      Provider.of<AppProvider>(context, listen: false)
                          .likeTrip(trip);
                    },
                  ),
                  InkWell(
                    child: Icon(
                      Icons.share,
                      size: 50.h,
                    ),
                    onTap: () {},
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(trip.description),
            )
          ],
        ),
      );
    });
  }
}
