import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:demo/date_repo/enum.dart';
import 'package:demo/provider/CompanyProvider.dart';

class CategoryWidget extends StatelessWidget {
  Category category;
  String label;

  CategoryWidget({
    Key? key,
    required this.category,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(builder: (context, provider, c) {
      return Container(
          height: 50.h,
          child: ElevatedButton(
            style: TextButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: provider.initCategories[category]!
                    ? Colors.blue
                    : (provider.isDark ? Colors.black : Colors.white)),
            onPressed: () {
              provider.toggleCategory(category);
            },
            child: Text("#${label}",
                style: TextStyle(
                    color: (provider.isDark ? Colors.white : Colors.black))),
          ));
    });
  }
}
