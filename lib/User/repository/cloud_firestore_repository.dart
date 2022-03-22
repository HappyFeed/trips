import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trips_app/User/model/user.dart';
import 'package:trips_app/User/ui/widgets/profile_place.dart';

import '../../Place/model/place.dart';
import 'cloud_firestore_api.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(UserModel user) =>
      _cloudFirestoreAPI.updateUserData(user);

  Future<void> updatePlaceDate(Place place) =>
      _cloudFirestoreAPI.updatePlaceDate(place);

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreAPI.buildMyPlaces(placesListSnapshot);
}
