import 'package:flutter/material.dart';

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
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Colors.black87),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: ListTile(
            iconColor: Colors.white,
            leading: icon,
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            title: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
            onTap: () => function(),
          ),
        ),
      ),
    );
  }
}
