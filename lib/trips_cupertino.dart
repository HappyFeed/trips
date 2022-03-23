import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:trips_app/User/bloc/bloc_user.dart';

import 'Place/ui/screens/home_trips.dart';
import 'User/ui/screens/profile_trips.dart';
import 'Place/ui/screens/search_trips.dart';

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
              builder: (BuildContext context) {
                return BlocProvider(
                  bloc: UserBloc(),
                  child: HomeTrips(),
                );
              },
            );

          case 1:
            return CupertinoTabView(
              builder: (BuildContext context) => SearchTrips(),
            );

          case 2:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return BlocProvider<UserBloc>(
                    child: ProfileTrips(), bloc: UserBloc());
              },
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
