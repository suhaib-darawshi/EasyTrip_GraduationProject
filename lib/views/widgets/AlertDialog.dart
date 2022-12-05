import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertD extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Wrong Information".tr()),
      content: Text("Please Try Again".tr()),
      actions: [
        CupertinoDialogAction(
          child:Text("OK".tr()),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}