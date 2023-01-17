import 'dart:developer';

import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/User_Interface/widgets/firstIntro.dart';
import 'package:demo/User_Interface/widgets/secondIntroPage.dart';
import 'package:demo/User_Interface/widgets/thirdIntroPage.dart';
import 'package:demo/provider/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(viewportFraction: 1);
    final pages = [FirstIntroPage(), SecondIntroPage(), ThirdIntroPage()];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width / 1,
          height: MediaQuery.of(context).size.height / 2,
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Expanded(
                  child: Center(
                child: PageView.builder(
                  onPageChanged: (value) {
                    Provider.of<AppProvider>(context, listen: false)
                        .changePage(value);
                  },
                  controller: pageController,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
              )),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 10.h,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5)),
              width: Provider.of<AppProvider>(context).pageIndexIntro == 0
                  ? 25.w
                  : 10.w,
            ),
            SizedBox(
              width: 5.w,
            ),
            Container(
              height: 10.h,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(3)),
              width: Provider.of<AppProvider>(context).pageIndexIntro == 1
                  ? 25.w
                  : 10.w,
            ),
            SizedBox(
              width: 5.w,
            ),
            Container(
              color: Colors.blue,
              height: 10.h,
              width: Provider.of<AppProvider>(context).pageIndexIntro == 2
                  ? 25.w
                  : 10.w,
            ),
          ],
        ),
        Provider.of<AppProvider>(context).pageIndexIntro == 2
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          AppRouter.router.pushReplace('WelcomeScreen');
                        },
                        child: Text("Try it Now ...")),
                  ],
                ),
              )
            : Center()
      ]),
    );
  }
}
