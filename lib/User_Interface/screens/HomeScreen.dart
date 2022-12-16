import 'package:demo/provider/app_provider.dart';
import 'package:demo/User_Interface/screens/View.dart';
import 'package:demo/User_Interface/screens/searchScreen.dart';
import 'package:demo/User_Interface/screens/updateinformation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/SearchWdget.dart';

import 'personal_page.dart';

class HomeScreen extends StatelessWidget {
  List screens = [HomeView(), SearchScreen(), PersonalScreen()];
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
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        elevation: 1.5,
        backgroundColor: Provider.of<AppProvider>(context).isDark
            ? ((Provider.of<AppProvider>(context).getBarIndex() == 0)
                ? Colors.black
                : Colors.black)
            : Colors.white,
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
                    : (Provider.of<AppProvider>(context).isDark
                        ? Colors.white
                        : Colors.black),
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.search_sharp,
              color: (Provider.of<AppProvider>(context).getBarIndex() == 1)
                  ? Colors.blue
                  : (Provider.of<AppProvider>(context).isDark
                      ? Colors.white
                      : Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.person,
              color: (Provider.of<AppProvider>(context).getBarIndex() == 2)
                  ? Colors.blue
                  : (Provider.of<AppProvider>(context).isDark
                      ? Colors.white
                      : Colors.black),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Provider.of<AppProvider>(context).isDark
            ? Colors.black
            : Colors.white,
        elevation: 0,
        actions: [
          Provider.of<AppProvider>(context).getBarIndex() == 1
              ? IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: SearchWidget());
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                )
              : Padding(padding: EdgeInsets.zero),
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
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.menu,
              color: Provider.of<AppProvider>(context).isDark
                  ? Colors.blue
                  : Colors.black,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      body: screens[Provider.of<AppProvider>(context).getBarIndex()],
    );
  }
}
