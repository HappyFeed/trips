import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:trips_app/User/bloc/bloc_user.dart';
import '../../../User/model/user.dart';
import '../../model/place.dart';
import 'card_image.dart';

class CardImageList extends StatefulWidget {
  UserModel user;

  CardImageList(@required this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CardImageList();
  }
}

class _CardImageList extends State<CardImageList> {
  late UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
        height: 350.0,
        child: StreamBuilder(
            stream: userBloc.placesStream,
            builder: (context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  print("PLACESLIST: WAITING");
                  return CircularProgressIndicator();
                case ConnectionState.none:
                  print("PLACESLIST: NONE");
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  print("PLACESLIST: ACTIVE");
                  return listViewPlaces(
                      userBloc.buildPlaces(snapshot.data.docs, widget.user));
                //return listViewPlaces(userBloc.buildPlaces(snapshot.data.documents));
                case ConnectionState.done:
                  print("PLACESLIST: DONE");
                  return listViewPlaces(
                      userBloc.buildPlaces(snapshot.data.docs, widget.user));

                default:
                  print("PLACESLIST: DEFAULT");
                  return listViewPlaces(
                      userBloc.buildPlaces(snapshot.data.docs, widget.user));
              }
            }));
  }

  Widget listViewPlaces(List<Place> places) {
    void setLiked(Place place) {
      setState(() {
        place.liked = !place.liked;
        userBloc.likePlace(place, widget.user.uid);
      });
    }

    IconData iconDataLiked = Icons.favorite;
    IconData iconDataLike = Icons.favorite_border;
    return ListView(
      padding: EdgeInsets.all(25.0),
      scrollDirection: Axis.horizontal,
      children: places.map((place) {
        return CardImage(
          pathImage: place.uriImage,
          width: 300.0,
          height: 250.0,
          left: 20.0,
          iconData: place.liked ? iconDataLiked : iconDataLike,
          onPressedFabIcon: () {
            setLiked(place);
          },
          internet: true,
        );
      }).toList(),
    );
  }
}
/* ListView(
        padding: EdgeInsets.all(25.0),
        scrollDirection: Axis.horizontal,
        children: */