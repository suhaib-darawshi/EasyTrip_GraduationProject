import 'package:flutter/cupertino.dart';

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
              padding: const EdgeInsets.only(bottom: 20,right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(t.url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
