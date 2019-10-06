import 'package:flutter/material.dart';

class ImageCard extends StatefulWidget {
  ImageCard({Key key}) : super(key: key);

  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('by : AUTHOR', style: TextStyle(color: Colors.white),),
              Text('upvotes nb : 10', style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}