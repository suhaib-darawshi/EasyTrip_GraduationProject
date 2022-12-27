import 'package:demo/User_Interface/widgets/FavoritesList.dart';
import 'package:demo/provider/app_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FilteredTripScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<AppProvider>(context).isDark
            ? Colors.black
            : Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (() {
                Provider.of<AppProvider>(context, listen: false)
                    .setLocaleFromButton();
                context.setLocale(
                    Provider.of<AppProvider>(context, listen: false)
                        .getLocale());
              }),
              icon: const Icon(
                Icons.language,
                color: Colors.blue,
              )),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Provider.of<AppProvider>(context).isDark
          ? Colors.black
          : Colors.grey.shade100,
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          FavoritesTripsWidget(),
        ],
      ),
    );
  }
}
