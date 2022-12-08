import 'package:demo/provider/app_provider.dart';
import 'package:demo/User_Interface/screens/View.dart';
import 'package:demo/User_Interface/screens/searchScreen.dart';
import 'package:demo/User_Interface/screens/updateinformation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'personalPage.dart';

class HomeScreen extends StatelessWidget {
  List screens = [HomeView(), SearchScreen(), PersonalPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.amber,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                accountName:
                    Text(Provider.of<AppProvider>(context).user.first_name!),
                accountEmail:
                    Text(Provider.of<AppProvider>(context).user.email!))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        showSelectedLabels: false,
        elevation: 1.5,
        currentIndex: Provider.of<AppProvider>(context).homeScreenIndex,
        onTap: (value) {
          Provider.of<AppProvider>(context, listen: false)
              .updateBarIndex(value);
        },
        items: [
          BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.home,
                color: (Provider.of<AppProvider>(context).getBarIndex() == 0)
                    ? Colors.blue
                    : Colors.black,
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.search_sharp,
              color: (Provider.of<AppProvider>(context).getBarIndex() == 1)
                  ? Colors.blue
                  : Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.person,
              color: (Provider.of<AppProvider>(context).getBarIndex() == 2)
                  ? Colors.blue
                  : Colors.black,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (() {
                if (context.locale == const Locale('en')) {
                  context.setLocale(const Locale('ar'));
                } else {
                  context.setLocale(const Locale('en'));
                }
              }),
              icon: const Icon(
                Icons.language,
                color: Colors.blue,
              )),
        ],
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu,color: Colors.black,),
              onPressed: () {
                
                Scaffold.of(context).openDrawer();
              },
            );
          }
        ),
      ),
      body: screens[Provider.of<AppProvider>(context).getBarIndex()],
    );
  }
}
