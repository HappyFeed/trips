import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:trips_app/User/model/user.dart';
import 'package:trips_app/User/repository/auth_repository.dart';
import 'package:trips_app/User/repository/cloud_firestore_api.dart';
import 'package:trips_app/User/repository/cloud_firestore_repository.dart';

import '../../Place/model/place.dart';
import '../../Place/repository/firebase_storage_repository.dart';
import '../ui/widgets/profile_place.dart';

class UserBloc implements Bloc {
  final _authRepository = AuthRepository();

  //Flujo de datos - Streams
  //Streams - Firebase
  //SceamController
  Stream<User?> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User?> get authStatus => streamFirebase;

  Future<User?> currentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  //Caso de uso
  //1. SignIn a la aplicacion
  Future<UserCredential?> signIn() {
    return _authRepository.signInFirebase();
  }

  //2. Registrar en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(UserModel user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

  Future<void> updatePlaceDate(Place place) =>
      _cloudFirestoreRepository.updatePlaceDate(place);

  final _firebaseStorageRepository = FirebaseStorageRepository();
  Future<UploadTask> uploadFile(String path, File image) {
    // path, directory where to save
    // image, real file to store
    return _firebaseStorageRepository.uploadFile(path, image);
  }

  Stream<QuerySnapshot> placesListStream = FirebaseFirestore.instance
      .collection(CloudFirestoreAPI().PLACES)
      .snapshots();
  Stream<QuerySnapshot> get placesStream => placesListStream;

//MyPlaces
  List<ProfilePlace> mybuildPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreRepository.buildMyPlaces(placesListSnapshot);

  Stream<QuerySnapshot> myPlacesListStream(String uid) => FirebaseFirestore
      .instance
      .collection(CloudFirestoreAPI().PLACES)
      .where("userOwner",
          isEqualTo: FirebaseFirestore.instance
              .doc("${CloudFirestoreAPI().USERS}/${uid}"))
      .snapshots();

  //Places
  List<Place> buildPlaces(
          List<DocumentSnapshot> placesListSnapshot, UserModel user) =>
      _cloudFirestoreRepository.buildPlaces(placesListSnapshot, user);
  Future likePlace(Place place, String uid) =>
      _cloudFirestoreRepository.likePlace(place, uid);

  //Log out
  signOut() {
    _authRepository.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
