import 'package:demo/App_Router/App_Router.dart';
import 'package:demo/User_Interface/widgets/CustomTripWidget.dart';
import 'package:demo/models/trip.dart';
import 'package:demo/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchWidget extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Trip> results = Provider.of<AppProvider>(context)
        .defaultTrips
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.separated(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return CustomTripWidget(results[index]);
        },
        separatorBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              color: Colors.black,
            ),
          );
        }),
        itemCount: results.length);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Trip> results = Provider.of<AppProvider>(context)
        .defaultTrips
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(results[index].name),
            onTap: () {
              Provider.of<AppProvider>(context, listen: false)
                  .setCurrentTrip(results[index]);
              AppRouter.router.push("DetailPage");
            },
          );
        },
        separatorBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              color: Colors.black,
            ),
          );
        }),
        itemCount: results.length);
  }
}
