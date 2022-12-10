import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../models/trip.dart';
import '../../provider/app_provider.dart';
import '../screens/DetailPage.dart';

class TripWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
      
      itemCount: Provider.of<AppProvider>(context).advancedTrip.length,
      itemBuilder: (context, index) {
        Trip t = Provider.of<AppProvider>(context,listen: false).advancedTrip[index];
        return InkWell(
          onTap: () {
            Provider.of<AppProvider>(context,listen: false ).setCurrentTrip(t);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return DetailPage(
                trip: t,
              );
            }));
          },
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom:20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    t.url,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.5,
                  ),
                ),
              ),
              Positioned(
                bottom: 50.h,
                left: 15.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        t.location,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.h),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        t.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30.h),
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
      separatorBuilder: (context, index) => SizedBox(
        height: 15.h,
      ),
    )
    );
  }
}