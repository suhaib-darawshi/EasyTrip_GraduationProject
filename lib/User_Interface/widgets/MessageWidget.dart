import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/message.dart';

class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: message.isSender ? Colors.blue : Colors.grey.shade300,
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: message.isSender ? Colors.white : Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
