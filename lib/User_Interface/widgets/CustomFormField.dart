import 'package:demo/provider/CompanyProvider.dart';
import 'package:demo/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  final Function validation;
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType textInputType;
  final Icon icon;

  const CustomTextField(
      {Key? key,
      required this.validation,
      required this.label,
      required this.controller,
      this.isPassword = false,
      this.textInputType = TextInputType.text,
      this.icon = const Icon(
        Icons.abc,
        color: Colors.blue,
        size: 35,
      )})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (v) => validation(v),
            controller: controller,
            obscureText: isPassword,
            style: TextStyle(
                color: Provider.of<AppProvider>(context).asCompany
                    ? (Provider.of<CompanyProvider>(context).isDark
                        ? Colors.white
                        : Colors.black)
                    : (Provider.of<AppProvider>(context).isDark
                        ? Colors.white
                        : Colors.black)),
            decoration: InputDecoration(
              icon: icon,
              label: Text(
                label,
                style: TextStyle(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            keyboardType: textInputType,
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
}
