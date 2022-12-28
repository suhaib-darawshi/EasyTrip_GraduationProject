import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/User_Interface/widgets/CustomFormField.dart';
import 'package:demo/provider/CompanyProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddTrip extends StatelessWidget {
  const AddTrip({super.key});

  @override
  Widget build(BuildContext context) {
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
                    color: Colors.grey,
                    child: provider.imageFile == null
                        ? Center(
                            child: Text(
                            "Pick Image".tr(),
                            style: TextStyle(
                                fontSize: 25, fontStyle: FontStyle.italic),
                          ))
                        : Image.file(provider.imageFile!),
                  ),
                ),
                CustomTextField(
                    validation: provider.requiredValidation,
                    label: "Trip title".tr(),
                    controller: provider.tripNameContrller),
                CustomTextField(
                  validation: provider.requiredValidation,
                  label: "Trip Location".tr(),
                  controller: provider.tripLocationController,
                  icon: Icon(
                    Icons.location_on_outlined,
                    color: Colors.blue,
                    size: 35.h,
                  ),
                ),
                CustomTextField(
                    validation: () {},
                    label: "Trip Description".tr(),
                    controller: provider.tripDescriptionController),
                CustomTextField(
                  validation: () {},
                  label: "Trip Price".tr(),
                  controller: provider.tripPriceController,
                  icon: Icon(
                    Icons.monetization_on,
                    color: Colors.yellow,
                    size: 35.h,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      AppRouter.router.push('AddTripScreen2');
                    },
                    child: Text("Next".tr()))
              ],
            ),
          ),
        ),
      );
    });
  }
}
