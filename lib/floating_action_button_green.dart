import 'package:flutter/material.dart';

class FloatingActionButtonGreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FloatingActionButtonGreen();
  }
}

class _FloatingActionButtonGreen extends State<FloatingActionButtonGreen>
    with AutomaticKeepAliveClientMixin {
  late IconData icon;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    this.icon = Icons.favorite_border;
  }

  void onFavPressed() {
    setState(() {
      if (this.icon == Icons.favorite_border) {
        this.icon = Icons.favorite;
      } else {
        this.icon = Icons.favorite_border;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
      backgroundColor: Color(0xFF11DA53),
      mini: true,
      tooltip: "Fav",
      onPressed: onFavPressed,
      child: Icon(this.icon),
    );
  }
}
