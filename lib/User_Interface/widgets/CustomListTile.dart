import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Icon icon;
  final String title;
  final Function onTap;
  const CustomListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      
      title: Text(title),
      trailing: icon,
      leading: icon,
    );
  }
}
