import 'package:demo/User_Interface/widgets/FavoritesList.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';
import '../../models/trip.dart';
import '../../provider/app_provider.dart';
import '../widgets/CustomTripWidget.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (() {
                if (context.locale == const Locale('en')) {
                  context.setLocale(const Locale('ar'));
                } else {
                  context.setLocale(const Locale('en'));
                }
              }),
              icon: const Icon(
                Icons.language,
                color: Colors.blue,
              )),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Expanded(
        child: ListView.separated(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
      itemCount: Provider.of<AppProvider>(context).history.length,
      itemBuilder: (context, index) {
        Trip t =
            Provider.of<AppProvider>(context, listen: false).history[index];
        return InkWell(
            onTap: () async{
              await Provider.of<AppProvider>(context, listen: false)
                  .setCurrentTrip(t);
              AppRouter.router.push("DetailPage");
            },
            child: CustomTripWidget(t));
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 15.h,
      ),
    ))
        ],
      ),
    );
  }
}
