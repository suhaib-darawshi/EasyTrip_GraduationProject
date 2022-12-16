import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
