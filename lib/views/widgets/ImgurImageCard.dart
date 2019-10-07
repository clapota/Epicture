import 'package:flutter/material.dart';

class ImageCard extends StatefulWidget {
  ImageCard({Key key, this.image}) : super(key: key);

  final Image image;
  _ImageCardState createState() => _ImageCardState();

}

class _ImageCardState extends State<ImageCard> {
  void showImage() {

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Card(
        elevation: 10,
        color: Color(0xFFf7418c),
        margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('by : AUTHOR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15),),
                Text('upvotes nb : 10', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
              ],
            ),
            Padding(padding: const EdgeInsets.fromLTRB(0, 20, 0, 0), 
            child: 
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DetailScreen(image: this.widget.image);
                }));
              },
              child: this.widget.image
            ),
            )
          ],
        ),
      )
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key key, this.image}) : super(key: key);

  final Image image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: this.image
        ),
        onTap: () => Navigator.pop(context),
      )
    );
  }
}