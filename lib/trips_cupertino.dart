import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'home_trips.dart';
import 'profile_trips.dart';
import 'search_trips.dart';

class TripsCupertino extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        bottomNavigationBar: CupertinoTabScaffold(
      tabBar: CupertinoTabBar(activeColor: Colors.indigo, items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
      ]),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (BuildContext context) => HomeTrips(),
            );

          case 1:
            return CupertinoTabView(
              builder: (BuildContext context) => SearchTrips(),
            );

          case 2:
            return CupertinoTabView(
              builder: (BuildContext context) => ProfileTrips(),
            );
          default:
            return CupertinoTabView(
              builder: (BuildContext context) => HomeTrips(),
            );
        }
      },
    ));
  }
}
