import 'dart:developer';

import 'package:demo/adminInterface/widgets/UserWidget.dart';
import 'package:demo/provider/AdminProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';
import 'ButtonCell.dart';
import 'CellWidget.dart';

class UsersTable extends StatelessWidget {
  const UsersTable({super.key});

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
              'USERS TABLE',
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
                  CellWidget(text: 'email', height: 100),
                  CellWidget(text: 'phone', height: 100),
                  CellWidget(text: 'booked trips', height: 100),
                  CellWidget(text: 'role', height: 100),
                  CellWidget(text: 'Actions', height: 100),
                  CellWidget(text: 'Remove', height: 100),
                ]),
                ...provider.users.map((e) {
                  return TableRow(children: [
                    CellWidget(text: e.first_name!),
                    CellWidget(text: e.email!),
                    CellWidget(text: e.phoneNumber!),
                    CellWidget(text: e.booked_trips!.length.toString()),
                    DropdownButton<String>(
                      items: [
                        DropdownMenuItem(
                          child: Text('Super Admin'),
                          value: 'Super Admin',
                        ),
                        DropdownMenuItem(
                          child: Text('standard'),
                          value: 'standard',
                        )
                      ],
                      value: provider.users[provider.users.indexOf(e)].role,
                      onChanged: (value) {
                        provider.users[provider.users.indexOf(e)].role = value;
                        log(provider.users[provider.users.indexOf(e)].role!);
                        provider.not();
                      },
                    ),
                    ButtonCell(
                        function: () async {
                          await provider.updateUser(
                              provider.users[provider.users.indexOf(e)]);
                        },
                        text: 'Update'),
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
                                          await provider.deleteUser(e);
                                          AppRouter.router.pop();
                                        },
                                        child: Text("yes")),
                                  ],
                                );
                              }));
                        },
                        color: Colors.red,
                        text: 'Delete')
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
