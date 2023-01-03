import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../provider/CompanyProvider.dart';
import 'C_CustomTripWidget.dart';

class NonActiveTrips extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(builder: (context, provider, c) {
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: provider.nonActiveTrips.length,
                itemBuilder: (context, index) {
                  return CompanyViewTripWidget(provider.nonActiveTrips[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20.h,
                  );
                },
              ),
            )
          ],
        );
      });
  }
}