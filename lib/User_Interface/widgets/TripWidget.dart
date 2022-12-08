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
            Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
              return DetailPage(trip: t);
            })));
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  t.url,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height/1.8,
                  fit: BoxFit.cover,
                ),
              ),
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
                            fontSize: 20.w, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        t.name,
                        style: TextStyle(
                            fontSize: 20.w, fontWeight: FontWeight.bold),
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
        height: 15.h,
      ),
    )
    );
  }
}