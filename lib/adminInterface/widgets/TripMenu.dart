import 'package:demo/adminInterface/widgets/ButtonCell.dart';
import 'package:demo/adminInterface/widgets/CellWidget.dart';
import 'package:demo/adminInterface/widgets/tripTableItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';
import '../../provider/AdminProvider.dart';

class TripMenu extends StatelessWidget {
  const TripMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, x) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100.h),
            Text(
              'Trips in use',
              style: TextStyle(fontSize: 55.w, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 100.h),
            Table(
              border: TableBorder.all(
                width: 1,
              ),
              children: [
                TableRow(children: [
                  CellWidget(
                    text: 'name',
                    height: 100,
                  ),
                  CellWidget(text: 'location', height: 100),
                  CellWidget(text: 'price', height: 100),
                  CellWidget(text: 'company', height: 100),
                  CellWidget(text: 'rate', height: 100),
                  CellWidget(text: 'Active', height: 100),
                  CellWidget(text: 'Approved', height: 100),
                  CellWidget(text: 'Remove', height: 100),
                ]),
                ...provider.trips.map((e) {
                  return TableRow(children: [
                    CellWidget(text: e.name),
                    CellWidget(text: e.location),
                    CellWidget(text: e.price),
                    CellWidget(text: e.companyid.name),
                    CellWidget(text: e.rate.toString()),
                    ButtonCell(
                      function: () async {
                        await provider.lockTrip(provider.trips.indexOf(e));
                      },
                      text: e.available ? 'Active' : 'Not Active',
                      color: e.available ? Colors.green : Colors.red,
                    ),
                    ButtonCell(
                      function: () async {
                        await provider.approveTrip(provider.trips.indexOf(e));
                      },
                      text: e.approved ? 'Approved' : 'Not Approved',
                      color: e.approved ? Colors.green : Colors.red,
                    ),
                    ButtonCell(
                      function: () async {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                title: Text("WARNING"),
                                content: Text(
                                    "Are you sure you want to delete it ?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        AppRouter.router.pop();
                                      },
                                      child: Text("no")),
                                  TextButton(
                                      onPressed: () async {
                                        await provider.deleteTrip(e);
                                        AppRouter.router.pop();
                                      },
                                      child: Text("yes")),
                                ],
                              );
                            }));
                      },
                      text: 'Remove',
                      color: Colors.red,
                    ),
                  ]);
                })
              ],
            ),
          ],
        ),
      );
    });
  }
}
