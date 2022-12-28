import 'dart:developer';

import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/User_Interface/widgets/CustomFormField.dart';
import 'package:demo/provider/CompanyProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddTripScreen2 extends StatelessWidget {
  const AddTripScreen2({super.key});

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
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Please Fill the Information'.tr(),
                    style: TextStyle(fontSize: 20.w),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                      icon: Icon(
                        Icons.home_work_outlined,
                        color: Colors.blue,
                        size: 35.w,
                      ),
                      validation: provider.requiredValidation,
                      label: 'Hotel Name'.tr(),
                      controller: provider.tripHotelController),
                  Row(
                    children: [
                      SizedBox(
                        width: 25.w,
                      ),
                      Text(
                        'Hotel Rank :',
                        style: TextStyle(fontSize: 22.w),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      DropdownButton<String>(
                        hint: Text('choose'.tr()),
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
                    ],
                  ),
                  CustomTextField(
                      icon: Icon(
                        Icons.flight,
                        color: Colors.blue,
                        size: 35.w,
                      ),
                      validation: provider.requiredValidation,
                      label: 'Flight Company'.tr(),
                      controller: provider.tripFlightController),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextField(
                      icon: Icon(
                        Icons.numbers,
                        color: Colors.blue,
                        size: 35.w,
                      ),
                      validation: isNumeric,
                      textInputType: TextInputType.number,
                      label: 'Book Limit'.tr(),
                      controller: provider.tripLimitController),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () async {
                              provider.begin = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate:
                                      DateTime.now().add(Duration(days: 730)));
                            },
                            child: Text('Choose Date'.tr())),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Duration :',
                              style: TextStyle(
                                fontSize: 22.w,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  provider.decDuration();
                                },
                                icon: Icon(
                                  Icons.remove,
                                  color: Colors.blue,
                                )),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(provider.duration.toString()),
                            SizedBox(
                              width: 5.w,
                            ),
                            IconButton(
                                onPressed: () => provider.incDuration(),
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.blue,
                                ))
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
                  ElevatedButton(
                      onPressed: () async {
                        await provider.addTrip();
                      },
                      child: Text('Add Trip'.tr()))
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
