import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
            IconButton(
                onPressed: (() {
                  if (context.locale == Locale('en')) {
                    context.setLocale(Locale('ar'));
                  } else {
                    context.setLocale(Locale('en'));
                  }
                }),
                icon: Icon(Icons.language))
          ],
      ),
    );
  }
}