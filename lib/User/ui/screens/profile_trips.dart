import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:trips_app/User/bloc/bloc_user.dart';
import 'package:trips_app/User/model/user.dart';
import 'profile_header.dart';
import '../widgets/profile_places_list.dart';
import '../widgets/profile_background.dart';

class ProfileTrips extends StatelessWidget {
  late UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    // TODO: implement build
    /*return Container(
      color: Colors.indigo,
    );*/
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.none:
            return CircularProgressIndicator();
          case ConnectionState.active:
            return showProfileData(snapshot);
          case ConnectionState.done:
            return showProfileData(snapshot);
          default:
            return showProfileData(snapshot);
        }
      },
    );

    /*Stack(
      children: <Widget>[
        ProfileBackground(),
        ListView(
          children: <Widget>[ProfileHeader(), ProfilePlacesList()],
        ),
      ],
    );*/
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      print("logeado");
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[Text("usuario no logeado. Haz login")],
          ),
        ],
      );
    } else {
      print("logeado");
      var user = UserModel(
          uid: snapshot.data.uid,
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoUrl: snapshot.data.photoURL);

      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[ProfileHeader(user), ProfilePlacesList(user)],
          ),
        ],
      );
    }
  }
}
