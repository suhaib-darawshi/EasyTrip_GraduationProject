import 'package:demo/User_Interface/widgets/CustomTripWidget.dart';
import 'package:demo/User_Interface/widgets/SearchWdget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';
import '../../provider/app_provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<AppProvider>(context).isDark
          ? Colors.black
          : Colors.grey.shade200,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    return CustomTripWidget(
                        Provider.of<AppProvider>(context, listen: false)
                            .defaultTrips[index]);
                  },
                  separatorBuilder: ((context, index) {
                    return SizedBox(
                      height: 10.h,
                    );
                  }),
                  itemCount:
                      Provider.of<AppProvider>(context).defaultTrips.length),
            )
          ],
        ),
      ),
    );
  }
}
