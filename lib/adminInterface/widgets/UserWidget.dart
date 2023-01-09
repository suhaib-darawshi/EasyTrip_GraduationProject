import 'dart:developer';
import 'dart:js_util';

import 'package:demo/provider/AdminProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key, required this.user});
  final int user;
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, x) {
      return Container(
        height: 100.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(provider.users[user].id!)),
            Expanded(
                child: Text(
                    "${provider.users[user].first_name!} ${provider.users[user].last_name!}")),
            Expanded(child: Text(provider.users[user].email!)),
            Expanded(
                child: DropdownButton<String>(
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
              value: provider.users[user].role,
              onChanged: (value) {
                provider.users[user].role = value;
                log(provider.users[user].role!);
                provider.not();
              },
            )),
            Expanded(child: Text(provider.users[user].phoneNumber!)),
            Expanded(
                child:
                    Text(provider.users[user].booked_trips!.length.toString())),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    child: Text("Apply"),
                    onPressed: () async {
                      await Provider.of<AdminProvider>(context, listen: false)
                          .updateUser(provider.users[user]);
                    },
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  flex: 4,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.red),
                    child: Text("Remove"),
                    onPressed: () async {
                      await provider.deleteUser(provider.users[user]);
                    },
                  ),
                ),
              ],
            )),
          ],
        ),
      );
    });
  }
}
