import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/trip.dart';

class pageview extends StatelessWidget {
  int ind = 0;
  @override
  Widget build(BuildContext context) {
    List<Trip> list = Provider.of<AppProvider>(context).defaultTrips;
    return Scaffold(
      appBar: AppBar(title: Text('Basic demo')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              disableCenter: true,
            ),
            items: list
                .map((item) => Container(
                      child: Image.network(
                        item.url,
                        fit: BoxFit.cover,
                      ),
                    ))
                .toList(),
          )),
          Text(
            "All Trips",
            textAlign: TextAlign.left,
          ),
          Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10),
                  itemCount: list.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      child: Image.network(
                        list[index].url,
                        width: 100,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    );
                  })))
        ],
      ),
    );
  }
}
