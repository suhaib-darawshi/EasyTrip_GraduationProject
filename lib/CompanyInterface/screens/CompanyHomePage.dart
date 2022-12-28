import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/User_Interface/widgets/CustomTripWidget.dart';
import 'package:demo/provider/CompanyProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../widgets/C_CustomTripWidget.dart';

class CompanyHomePage extends StatelessWidget {
  const CompanyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<CompanyProvider>(context, listen: false)
                    .setLocaleFromButton();
                context.setLocale(
                    Provider.of<CompanyProvider>(context, listen: false)
                        .getLocale());
              },
              icon: Icon(
                Icons.language,
                color: Colors.black,
              ))
        ],
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        }),
      ),
      drawer: Drawer(
        child: Column(
          children: [],
        ),
      ),
      body: Consumer<CompanyProvider>(builder: (context, provider, c) {
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: provider.companyTrips.length,
                itemBuilder: (context, index) {
                  return CompanyViewTripWidget(provider.companyTrips[index]);
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
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CompanyProvider>(context, listen: false).imageFile = null;
          AppRouter.router.push("AddTrip");
        },
        child: Icon(
          Icons.add,
          size: 35.w,
        ),
      ),
    );
  }
}
