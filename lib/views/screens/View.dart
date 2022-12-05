import 'package:demo/views/widgets/MostPopular.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/travelBlog.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: HomeView(),
  ));
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Travel Blog",
              style: TextStyle(fontSize: 36),
            ),
          ),
          Expanded(
            child: TravelBlog(),
            flex: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Most Popular",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "View All",
                  style: TextStyle(fontSize: 16, color: Colors.deepOrange),
                )
              ],
            ),
          ),
          Expanded(child: MostPopular(), flex: 1)
        ],
      ),
    );
  }
}
