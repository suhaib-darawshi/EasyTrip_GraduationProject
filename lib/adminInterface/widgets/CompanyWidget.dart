import 'package:demo/provider/AdminProvider.dart';
import 'package:flutter/material.dart';

import 'package:demo/models/companyModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';

class CompanyWidget extends StatelessWidget {
  CompanyWidget({
    Key? key,
    required this.company,
  }) : super(key: key);
  final int company;
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, x) {
      return Container(
        height: 100.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(provider.companies[company].id!)),
            Expanded(
              child: Text("${provider.companies[company].name}"),
            ),
            Expanded(child: Text(provider.companies[company].email)),
            Expanded(child: Text(provider.companies[company].address)),
            Expanded(child: Text(provider.companies[company].phone)),
            Expanded(child: Text(provider.companies[company].rank.toString())),
            Expanded(
              child: ElevatedButton(
                style: TextButton.styleFrom(backgroundColor: Colors.red),
                child: Text("Remove"),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: Text("WARNING"),
                          content: Text("Are you sure you want to delete it ?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  AppRouter.router.pop();
                                },
                                child: Text("no")),
                            TextButton(
                                onPressed: () async {
                                  await provider.deleteCompany(
                                      provider.companies[company]);
                                  AppRouter.router.pop();
                                },
                                child: Text("yes")),
                          ],
                        );
                      }));
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
