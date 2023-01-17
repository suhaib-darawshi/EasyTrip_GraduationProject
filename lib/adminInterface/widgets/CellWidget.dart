import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CellWidget extends StatelessWidget {
  double height;
  String text;
  CellWidget({
    Key? key,
    this.height = 70,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: height != 70 ? Colors.grey : Colors.white,
        height: 70.h,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: height != 70
                ? TextStyle(
                    fontSize: 30.w,
                    fontWeight: FontWeight.bold,
                  )
                : TextStyle(
                    fontSize: 23.w,
                  ),
          ),
        ),
      ),
    );
  }
}
