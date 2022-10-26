import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/trip.dart';

class TravelBlog extends StatelessWidget {
  final List<Trip> l = Trip.generateTrips;
  final pageController = PageController(viewportFraction: 0.9);
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: l.length,
      itemBuilder: (context, index) {
        var t = l[index];
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20,top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  t.url,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      t.location,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      t.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 30,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.arrow_forward,color: Colors.white,size: 30,),
              ),
            )
          ],
        );
      },
    );
  }
}
