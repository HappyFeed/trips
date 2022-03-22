import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:trips_app/Place/ui/widgets/card_image.dart';
import 'package:trips_app/Place/ui/widgets/title_input_location.dart';
import 'package:trips_app/User/bloc/bloc_user.dart';
import 'package:trips_app/widgets/gradient_back.dart';
import 'package:trips_app/widgets/text_input.dart';
import 'package:trips_app/widgets/title_header.dart';

import '../../../widgets/button_purple.dart';
import '../../model/place.dart';

class AddPlaceScreen extends StatefulWidget {
  File image;

  AddPlaceScreen({Key? key, required this.image});

  @override
  State<StatefulWidget> createState() {
    return _AddPlaceScreen();
  }
}

class _AddPlaceScreen extends State<AddPlaceScreen> {
  final _controllerTitlePlace = TextEditingController();
  final _controllerDescriptionPlace = TextEditingController();
  final _controllerLocationPlace = TextEditingController();

  late UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        GradientBack(height: 300.0),
        Row(
          //AppBar
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 25.0, left: 5.0),
              child: SizedBox(
                height: 45.0,
                width: 45.0,
                child: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.white,
                    size: 45,
                  ),
                  onPressed: () => {Navigator.pop(context)},
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.only(top: 45.0, left: 10.0, right: 10.0),
                child: TitleHeader(title: "Add a new Place"),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 120.0, bottom: 20.0),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: CardImage(
                    pathImage: widget.image.path,
                    iconData: Icons.camera_alt,
                    height: 200,
                    width: 250,
                    left: 20,
                    onPressedFabIcon: () {}),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextInput(
                  hintText: "Title",
                  inputType: null,
                  maxLines: 1,
                  controller: _controllerTitlePlace,
                ),
              ),
              TextInput(
                inputType: TextInputType.multiline,
                hintText: "Description",
                controller: _controllerDescriptionPlace,
                maxLines: 4,
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextInputLocation(
                  hintText: "Add location",
                  iconData: Icons.location_on,
                  controller: _controllerLocationPlace,
                ),
              ),
              Container(
                width: 70.0,
                child: ButtonPurple(
                  buttonText: "Add Place",
                  onPressed: () {
                    //1. Firebase Storage
                    //url -
                    //Id del usuario logeado actualmente
                    userBloc.currentUser().then((User? user) {
                      if (user != null) {
                        String uid = user.uid;
                        String path = "${uid}/${DateTime.now().toString()}.jpg";
                        //change RULE in Firebase Storage console to = allow read, write: if request.auth != null;
                        userBloc
                            .uploadFile(path, widget.image)
                            .then((UploadTask uploadTask) {
                          uploadTask.then((TaskSnapshot snapshot) {
                            snapshot.ref.getDownloadURL().then((urlImage) {
                              print("URLIMAGE: ${urlImage}");
                              //2. Cloud Firestore
                              //Place - title, description, url, userOwner, likes
                              userBloc
                                  .updatePlaceDate(Place(
                                      name: _controllerTitlePlace.text,
                                      description:
                                          _controllerDescriptionPlace.text,
                                      likes: 0,
                                      uriImage: urlImage))
                                  .whenComplete(() {
                                print("Termino");
                                Navigator.pop(context);
                              });
                            });
                          });
                        });
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
