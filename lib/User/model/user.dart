import 'package:flutter/material.dart';

import '../../Place/model/place.dart';

class UserModel {
  final String? uid;
  final String name;
  final String email;
  final String photoUrl;
  final List<Place>? myPlaces;
  final List<Place>? myFavoritePlaces;

  UserModel({
    Key? key,
    this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    this.myFavoritePlaces,
    this.myPlaces,
  });
}
