import 'dart:developer';

import 'package:demo/adminInterface/widgets/UserWidget.dart';
import 'package:demo/provider/AdminProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersTable extends StatelessWidget {
  const UsersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, x) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('id')),
                Expanded(child: Text('name')),
                Expanded(child: Text('email')),
                Expanded(child: Text('role')),
                Expanded(child: Text('phone number')),
                Expanded(child: Text('booked trips')),
                Expanded(
                  child: Center(),
                )
              ],
            ),
            Expanded(
                child: ListView.separated(
                    itemBuilder: ((context, index) {
                      return UserWidget(user: index);
                    }),
                    separatorBuilder: ((context, index) {
                      return Divider(
                        color: provider.isDark ? Colors.white : Colors.black,
                      );
                    }),
                    itemCount: provider.users.length)),
          ],
        ),
      );
    });
  }
}
