import 'package:demo/date_repo/enum.dart';
import 'package:demo/provider/CompanyProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';
import '../widgets/CategoryWidget.dart';

class AddCategoriesScreen extends StatelessWidget {
  const AddCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(builder: (context, provider, c) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: provider.isDark ? Colors.black : Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: provider.isDark ? Colors.white : Colors.black,
            ),
            onPressed: () {
              AppRouter.router.pop();
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                'Please fill up some categories to help us promote the trip :',
                style: TextStyle(
                    fontSize: 20, textBaseline: TextBaseline.ideographic),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryWidget(
                    category: Category.ancient,
                    label: 'ancient',
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  CategoryWidget(
                    category: Category.beach,
                    label: 'beach',
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  CategoryWidget(
                    category: Category.cheap,
                    label: 'cheap',
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  CategoryWidget(
                    category: Category.desert,
                    label: 'desert',
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CategoryWidget(
                    category: Category.mountant,
                    label: 'mountant',
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  CategoryWidget(
                    category: Category.religous,
                    label: 'religous',
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  CategoryWidget(
                    category: Category.scientific,
                    label: 'scientific',
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CategoryWidget(
                    category: Category.developedCity,
                    label: 'developedCity',
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  CategoryWidget(
                    category: Category.expensive,
                    label: 'expensive',
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  CategoryWidget(
                    category: Category.greenLand,
                    label: 'nature',
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            ElevatedButton(
                onPressed: () async {
                  await provider.addTrip();
                  AppRouter.router.pushReplace('companyHomePage');
                },
                child: Text('Finish ...')),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      );
    });
  }
}
