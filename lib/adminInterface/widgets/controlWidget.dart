import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ControlWidget extends StatelessWidget {
  Icon icon;
  Color color;
  String text;
  Function function;
  int numb;
  ControlWidget({
    Key? key,
    required this.icon,
    required this.color,
    required this.text,
    required this.function,
    required this.numb,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: Card(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.w),
                color: color,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    icon,
                    Column(
                      children: [
                        Text(
                          numb.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 35.w),
                        ),
                        Text(
                          text,
                          style: TextStyle(color: Colors.white, fontSize: 20.w),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.w),
                color: Colors.grey.shade300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          function();
                        },
                        child: Text(
                          'View Details',
                          style: TextStyle(color: color),
                        )),
                    Icon(
                      Icons.arrow_forward,
                      color: color,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
