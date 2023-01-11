import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonCell extends StatelessWidget {
  Function function;
  String text;
  Color color;
  ButtonCell(
      {Key? key,
      required this.function,
      required this.text,
      this.color = Colors.blue})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 70.h,
        child: Center(
            child: ElevatedButton(
          style: TextButton.styleFrom(
              backgroundColor: color, alignment: Alignment.center),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23.w, color: Colors.white),
            ),
          ),
          onPressed: () async {
            await function();
          },
        )),
      ),
    );
  }
}
