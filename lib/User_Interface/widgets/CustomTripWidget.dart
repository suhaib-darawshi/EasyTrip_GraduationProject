import 'package:demo/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../models/trip.dart';

class CustomTripWidget extends StatelessWidget {
  final Trip trip;
  CustomTripWidget(this.trip);
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Card(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
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
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width - 170,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Text(
                          trip.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        trip.isLiked
                            ? Positioned(
                                top: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    Provider.of<AppProvider>(context,
                                            listen: false)
                                        .setCurrentTrip(trip);
                                    Provider.of<AppProvider>(context,
                                            listen: false)
                                        .likeTrip(trip);
                                  },
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            : Positioned(
                                top: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    Provider.of<AppProvider>(context,
                                            listen: false)
                                        .setCurrentTrip(trip);
                                    Provider.of<AppProvider>(context,
                                            listen: false)
                                        .likeTrip(trip);
                                  },
                                  child: const Icon(Icons.favorite_border),
                                ))
                      ],
                    ),
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
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(trip.location)
                    ],
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
