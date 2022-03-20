import 'package:flutter/material.dart';
import 'package:trips_app/Place/ui/widgets/review.dart';
import 'package:trips_app/Place/ui/widgets/review_list.dart';

class ReviewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Review("assets/img/people.jpg", "Juan", "1 review 4 photos", "asdads"),
        Review("assets/img/girl.jpg", "Robin", "2 reiew 3 photos", "hgf"),
        Review("assets/img/ann.jpg", "Ann", "3 review 1 photo", "bcvbcv"),
      ],
    );
  }
}
