import 'package:demo/App_Router/App_Router.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../models/trip.dart';
import '../../provider/app_provider.dart';
import '../screens/DetailPage.dart';
import 'CustomTripWidget.dart';

class FavoritesTripsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
      itemCount: Provider.of<AppProvider>(context).likedTrips.length,
      itemBuilder: (context, index) {
        Trip t =
            Provider.of<AppProvider>(context, listen: false).likedTrips[index];
        return InkWell(
            onTap: () {
              Provider.of<AppProvider>(context, listen: false)
                  .setCurrentTrip(t);
              AppRouter.router.push("DetailPage");
            },
            child: CustomTripWidget(t));
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 15.h,
      ),
    ));
  }
}
