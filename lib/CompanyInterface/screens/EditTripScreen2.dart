import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../App_Router/App_Router.dart';
import '../../User_Interface/widgets/CustomFormField.dart';
import '../../provider/CompanyProvider.dart';

class EditTripScreen2 extends StatelessWidget {
  const EditTripScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Consumer<CompanyProvider>(
        builder: (context, provider, child) {
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
              title: Text(
                'Please Fill the Information'.tr(),
                style: TextStyle(
                    fontSize: 20.w,
                    color: provider.isDark ? Colors.white : Colors.black),
              ),
            ),
            backgroundColor: provider.isDark ? Colors.black : Colors.white,
            body: SingleChildScrollView(
              child: Form(
                key: provider.addTripKey2,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 35.w,
                        ),
                        Text(
                          'Hotel Rank(optional) :',
                          style: TextStyle(fontSize: 22.w),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              // border: Border.all(width: 1),
                              shape: BoxShape.rectangle),
                          child: DropdownButton<String>(
                            hint: Text(provider.currentTrip.hotelRank),
                            value: provider.hotelRank,
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            items: provider.hotelRanks
                                .map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem<String>(
                                  value: e, child: Text(e));
                            }).toList(),
                            onChanged: (value) {
                              provider.ChangeHotelRank(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomTextField(
                          icon: Icon(
                            Icons.home_work_outlined,
                            color: Colors.blue,
                            size: 35.w,
                          ),
                          validation: (c) {},
                          label: 'Hotel Name (optional)'.tr(),
                          controller: provider.tripHotelController),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomTextField(
                          icon: Icon(
                            Icons.flight,
                            color: Colors.blue,
                            size: 35.w,
                          ),
                          validation: provider.requiredValidation,
                          label: 'Flight Company'.tr(),
                          controller: provider.tripFlightController),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomTextField(
                          icon: Icon(
                            Icons.numbers,
                            color: Colors.blue,
                            size: 35.w,
                          ),
                          validation: provider.isANumber,
                          textInputType: TextInputType.number,
                          label: 'Book Limit'.tr(),
                          controller: provider.tripLimitController),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: InkWell(
                                  onTap: () async {
                                    provider.begin = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now()
                                            .add(Duration(days: 730)));
                                  },
                                  child: Text(
                                    'Choose Date'.tr(),
                                    style: TextStyle(
                                        fontSize: 24.w, color: Colors.blue),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  provider.begin != null
                                      ? Row(
                                          children: [
                                            Text(
                                              provider.begin!.year.toString() +
                                                  '-' +
                                                  provider.begin!.month
                                                      .toString() +
                                                  '-' +
                                                  provider.begin!.day
                                                      .toString(),
                                              style: TextStyle(fontSize: 24.w),
                                            ),
                                            SizedBox(
                                              width: 17.w,
                                            )
                                          ],
                                        )
                                      : Center(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Text(
                                      //   'Duration :',
                                      //   style: TextStyle(
                                      //     fontSize: 17.w,
                                      //   ),
                                      // ),
                                      InkWell(
                                        onTap: () {
                                          provider.decDuration();
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        provider.duration.toString() + ' days',
                                        style: TextStyle(fontSize: 17.w),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      InkWell(
                                        onTap: () => provider.incDuration(),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CheckboxListTile(
                          title: Text('Food Reserved :'.tr()),
                          value: provider.foodReserved,
                          onChanged: ((value) => provider.foodCkeckBox())),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CheckboxListTile(
                          title: Text('Car Rented :'.tr()),
                          value: provider.carRented,
                          onChanged: ((value) => provider.carCheckBox())),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              if (provider.toEditCategoryPage()) {
                                AppRouter.router.push('EditTripScreen3');
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Missing Information'.tr()),
                                      content: Text(
                                          'make sure you entered a proper information : \nduration>0 \nchoose a date'
                                              .tr()),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: Text("OK".tr()),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        )
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Text('Next'.tr())),
                        SizedBox(
                          width: 40.w,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
