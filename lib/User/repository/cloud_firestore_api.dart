import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trips_app/User/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../Place/model/place.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String PLACES = "places";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  void updateUserData(UserModel user) async {
    DocumentReference ref = _db.collection(USERS).doc(user.uid);
    return ref.set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoUrl,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSignIn': DateTime.now()
    }, SetOptions(merge: true));
  }

  Future<void> updatePlaceDate(Place place) async {
    CollectionReference refPlaces = _db.collection(PLACES);
    auth.User? user = _auth.currentUser;
    await refPlaces.add({
      'name': place.name,
      'descrption': place.description,
      'likes': place.likes,
      'urlImage': place.uriImage,
      'userOwner': _db.doc("${USERS}/${user!.uid}") //reference
    }).then((DocumentReference dr) {
      dr.get().then((DocumentSnapshot snapshot) {
        snapshot.id; //ID Place Referencia
        DocumentReference refUsers = _db.collection(USERS).doc(user.uid);
        refUsers.update({
          'myPlaces':
              FieldValue.arrayUnion([_db.doc("${PLACES}/${snapshot.id}")])
        });
      });
    });
  }
}
