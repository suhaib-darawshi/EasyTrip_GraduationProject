import 'package:demo/adminInterface/widgets/CompanyWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AdminProvider.dart';

class CompanyTable extends StatelessWidget {
  const CompanyTable({super.key});

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
                Expanded(child: Text('address')),
                Expanded(child: Text('phone number')),
                Expanded(child: Text('rank')),
                Expanded(
                  child: Center())
              ],

            ),
            Expanded(
                child: ListView.separated(
                    itemBuilder: ((context, index) {
                      return CompanyWidget(company: index);
                    }),
                    separatorBuilder: ((context, index) {
                      return Divider(
                        color: provider.isDark ? Colors.white : Colors.black,
                      );
                    }),
                    itemCount: provider.companies.length))
          ],
        ),
      );
    });
  }
}