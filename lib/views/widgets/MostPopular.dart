import 'package:demo/views/screens/DetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/trip.dart';

class MostPopular extends StatelessWidget {
  final List<Trip> l = Trip.generateTrips;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      scrollDirection: Axis.horizontal,
      itemCount: l.length,
      itemBuilder: (context, index) {
        var t = l[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
              return DetailPage(trip: t);
            })));
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  t.url,
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 20,
                left: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        t.location,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        t.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        width: 15,
      ),
    );
  }
}
