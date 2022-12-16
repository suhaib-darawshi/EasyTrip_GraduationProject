import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTile extends StatelessWidget {
  final String text;
  final Function function;
  final Icon icon;
  const CustomListTile({
    Key? key,
    required this.text,
    required this.function,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      width: 300.w,
      height: 70.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: ListTile(
            iconColor: Colors.black,
            leading: icon,
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
            title: Text(
              text,
              style: const TextStyle(color: Colors.black),
            ),
            onTap: () => function(),
          ),
        ),
      ),
    );
  }
}
