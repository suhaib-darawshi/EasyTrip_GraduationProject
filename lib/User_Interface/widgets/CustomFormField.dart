import 'package:flutter/material.dart';

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
      this.icon= const Icon(Icons.abc)
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (v) => this.validation(v),
      controller: this.controller,
      obscureText: isPassword,
      
      decoration: InputDecoration(
        icon: this.icon,
        labelText: this.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      keyboardType: this.textInputType,
    );
  }
}
