import 'package:epicture/objects/GalleryAlbum.dart';
import 'package:flutter/material.dart';

class AddCommentView extends StatefulWidget {
  AddCommentView({Key key, this.album}) : super(key: key);

  final GalleryAlbum album;

  _AddCommentViewState createState() => _AddCommentViewState();
}

class _AddCommentViewState extends State<AddCommentView> {
  void postComment() {
    //TODO: Faire ça
  }

  @override
  Widget build(BuildContext context) {
/*    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: const [Color(0xFFfbab66), Color(0xFFf7418c)],
                  stops: const [0.0, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: TextField(
                  maxLines: 4,
                  maxLength: 140,
                  decoration:
                      InputDecoration.collapsed(
                        hintText: 'Write a comment',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 2,
          left: 30,
          child: RawMaterialButton(
            onPressed: () {Navigator.pop(context);},
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
              size: 50.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(10),
          ),
        )
      ]),
    );*/
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 200,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            TextField(
              maxLines: 4,
              maxLength: 140,
              decoration: InputDecoration.collapsed(
                hintText: 'Write a comment',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            RaisedButton(
              child: Text('Post comment'),
              onPressed: postComment,
            )
          ],
        ),
      ),
    );
  }
}
