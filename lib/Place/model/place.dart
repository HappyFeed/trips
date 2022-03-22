import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Place {
  String? id;
  String name;
  String description;
  String uriImage;
  int? likes;
  User? userOwner;

  Place(
      {Key? key,
      required this.name,
      required this.description,
      required this.uriImage,
      this.userOwner,
      this.likes});
}
