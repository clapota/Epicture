import 'package:flutter/material.dart';
import 'package:epicture/views/widgets/PressableIconWidget.dart';

class ImageCard extends StatefulWidget {
  ImageCard({Key key, this.image}) : super(key: key);

  final Image image;

  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  void showImage() {}

  void onClick() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        elevation: 10,
        color: Colors.white,
        margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DetailScreen(image: this.widget.image);
                }));
              },
              child: this.widget.image),
          Container(
//            color: Theme.of(context).primaryColorDark,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
                gradient: LinearGradient(
                    colors: const [Color(0xFFFD60A3), Color(0xFFFF8961)],
                    stops: const [0.0, 1.0],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8, 8.0, 0),
                  child: Text('J\'ai trouvé un chat par terre c\'est devenu un pd',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    PressableIconWidget(iconData: Icons.thumb_up, label: '13', onClick: this.onClick, pressedColor: Colors.greenAccent,),
                    PressableIconWidget(iconData: Icons.thumb_down, label: '25K', onClick: this.onClick, pressedColor: Colors.black,),
                    PressableIconWidget(iconData: Icons.comment, label: '660', onClick: this.onClick, pressedColor: Colors.white,),
                    PressableIconWidget(iconData: Icons.remove_red_eye, label: '450K', onClick: this.onClick, pressedColor: Colors.white,),
                    PressableIconWidget(iconData: Icons.star,label: '', onClick:  this.onClick, pressedColor: Colors.yellow,)
                  ],
                )
              ],
            ),
          )
        ]),
      ),
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
      child: Center(child: this.image),
      onTap: () => Navigator.pop(context),
    ));
  }
}
