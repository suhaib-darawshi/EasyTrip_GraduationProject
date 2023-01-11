import 'package:demo/adminInterface/widgets/CompanyWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';
import '../../provider/AdminProvider.dart';
import 'ButtonCell.dart';
import 'CellWidget.dart';

class CompanyTable extends StatelessWidget {
  const CompanyTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, x) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.55,
        child: Table(
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
              CellWidget(text: 'address', height: 100),
              CellWidget(text: 'phone', height: 100),
              CellWidget(text: 'rank', height: 100),
              CellWidget(text: 'Remove', height: 100),
            ]),
            ...provider.companies.map((e) {
              return TableRow(children: [
                CellWidget(text: e.name),
                CellWidget(text: e.email),
                CellWidget(text: e.address),
                CellWidget(text: e.phone),
                CellWidget(text: e.rank.toString()),
                ButtonCell(
                    function: () async {
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
                                      provider.companies[provider.companies.indexOf(e)]);
                                  AppRouter.router.pop();
                                },
                                child: Text("yes")),
                          ],
                        );
                      }));
                    },
                    color: Colors.red,
                    text: 'Remove')
              ]);
            })
          ],
        ),
      );
    });
  }
}
