import 'package:demo/provider/app_provider.dart';
import 'package:demo/User_Interface/screens/DetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';
import '../../models/trip.dart';

class MostPopular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
      scrollDirection: Axis.horizontal,
      itemCount: Provider.of<AppProvider>(context).mostPopular.length,
      itemBuilder: (context, index) {
        Trip t =
            Provider.of<AppProvider>(context, listen: false).mostPopular[index];
        return InkWell(
          onTap: () async {
            await Provider.of<AppProvider>(context, listen: false)
                .setCurrentTrip(t);
            AppRouter.router.push("DetailPage");
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  t.url,
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  left: 7.w,
                  top: 11.h,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Text(
                        " " + t.rate.toString() + " ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.h),
                      ),
                    ),
                  )),
              Positioned(
                bottom: 20.h,
                left: 15.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        t.location,
                        style: TextStyle(
                            fontSize: 20.w,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        t.name,
                        style: TextStyle(
                            fontSize: 20.w,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        width: 15.w,
      ),
    );
  }
}
