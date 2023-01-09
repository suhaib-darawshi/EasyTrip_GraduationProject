import 'package:demo/provider/AdminProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListMenuIrem extends StatelessWidget {
  String name;
  int page;
  
  ListMenuIrem({
    Key? key,
    required this.name,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      onTap: () {
        Provider.of<AdminProvider>(context, listen: false)
            .setHomePageIndex(page);
      },
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
