import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/User_Interface/widgets/CustomFormField.dart';
import 'package:demo/provider/CompanyProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class AddTrip extends StatelessWidget {
  const AddTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Consumer<CompanyProvider>(builder: (context, provider, c) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                AppRouter.router.pop();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: provider.addTripKey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      provider.pickImageForCategory();
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 3.6,
                      // padding: EdgeInsets.only(top: 10.h),
                      color: Colors.white,
                      child: provider.imageFile == null
                          ? Center(
                              child: Text(
                              "Pick Image".tr(),
                              style: TextStyle(
                                  fontSize: 25.w, fontStyle: FontStyle.italic),
                            ))
                          : Image.file(
                              provider.imageFile!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: CustomTextField(
                        validation: provider.requiredValidation,
                        label: "Trip title".tr(),
                        controller: provider.tripNameContrller),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: CustomTextField(
                      validation: provider.requiredValidation,
                      label: "Trip Location".tr(),
                      controller: provider.tripLocationController,
                      icon: Icon(
                        Icons.location_on_outlined,
                        color: Colors.blue,
                        size: 35.h,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: CustomTextField(
                        validation: provider.requiredValidation,
                        label: "Trip Description".tr(),
                        controller: provider.tripDescriptionController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: CustomTextField(
                      validation: provider.isANumber,
                      label: "Trip Price".tr(),
                      controller: provider.tripPriceController,
                      textInputType: TextInputType.number,
                      icon: Icon(
                        Icons.monetization_on,
                        color: Colors.blue,
                        size: 35.h,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: TextButton.styleFrom(

                            // side: BorderSide(color: Colors.black),
                            backgroundColor:
                                provider.isDark ? Colors.black : Colors.blue),
                        onPressed: () {
                          if (provider.nextAddPage()) {
                            AppRouter.router.push('AddTripScreen2');
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Missing Information'.tr()),
                                  content: Text(
                                      'please fill the necessary infformation'
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
                        child: Container(
                          child: Text(
                            "Next".tr(),
                            style: TextStyle(
                                color: provider.isDark
                                    ? Colors.black
                                    : Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 53.w,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
