import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Place {
  String? id;
  String name;
  String description;
  String uriImage;
  int? likes;
  bool liked;
  //User? userOwner;

  Place(
      {Key? key,
      this.id,
      required this.name,
      required this.description,
      required this.uriImage,
      //this.userOwner,
      this.likes,
      this.liked = false});
}
