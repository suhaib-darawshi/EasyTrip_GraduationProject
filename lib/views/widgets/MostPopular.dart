import 'package:demo/provider/app_provider.dart';
import 'package:demo/views/screens/DetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/trip.dart';

class MostPopular extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      scrollDirection: Axis.horizontal,
      itemCount: Provider.of<AppProvider>(context).advancedTrip.length,
      itemBuilder: (context, index) {
        Trip t = Provider.of<AppProvider>(context,listen: false).advancedTrip[index];
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
                child: Image.network(
                  "http://10.0.2.2:8083/${t.url}",
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
