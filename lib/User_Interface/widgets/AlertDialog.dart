import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertD extends StatelessWidget {
  String message;
  AlertD(this.message, {super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Wrong Information".tr()),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          child: Text("OK".tr()),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}
