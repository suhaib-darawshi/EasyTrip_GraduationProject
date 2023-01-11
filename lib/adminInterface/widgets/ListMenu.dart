import 'package:demo/provider/AdminProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListMenuIrem extends StatelessWidget {
  String name;
  int page;
  Icon icon;
  ListMenuIrem({
    Key? key,
    required this.name,
    required this.page,
    this.icon=const Icon(Icons.abc_rounded)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon==Icon(Icons.abc_rounded)?Center():icon,
      title: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
      onTap: () {
        Provider.of<AdminProvider>(context, listen: false)
            .setHomePageIndex(page);
      },
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
      ),
    );
  }
}
