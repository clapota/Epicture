import 'package:epicture/ImgurAPI.dart';
import 'package:epicture/objects/Comment.dart';
import 'package:epicture/objects/GalleryAlbum.dart';
import 'package:epicture/views/addCommentView.dart';
import 'package:epicture/views/widgets/FadeRoute.dart';
import 'package:flutter/material.dart';
import 'package:epicture/views/widgets/CommentWidget.dart';

class CommentView extends StatefulWidget {
  CommentView({Key key, this.album, this.parent}) : super(key: key);

  final GalleryAlbum album;
  final Comment parent;

  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  Future<List<Comment>> fetchComment() async {
    final api = ImgurAPI();

    if (this.widget.album != null) {
      List<Comment> comments = await api.getCommentsFromId(
          this.widget.album.id);
      return comments;
    } else if (this.widget.parent != null) {
      List<Comment> comments = this.widget.parent.children;
      return comments;
    }
    return List<Comment>();
  }

  void addComment() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AddCommentView(album: this.widget.album),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Comment>>(
      future: fetchComment(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue,
                    child: RaisedButton.icon(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                      label: Text(''),
                    ),
                  ),
                  Container(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return CommentWidget(comment: snapshot.data[index]);
                      },
                    ),
                    height: MediaQuery.of(context).size.height - 100,
                  )
                ],
              ),
              Positioned(
                bottom: 75,
                right: 30,
                child: RawMaterialButton(
                  onPressed: this.addComment,
                  child: Icon(
                    Icons.add_comment,
                    color: Theme.of(context).primaryColor,
                    size: 50.0
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(10),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Column(
            children: <Widget>[
              Container(
                height: 50,
                color: Colors.blue,
                child: RaisedButton.icon(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  label: Text(''),
                ),
              ),
              Text('Error ' + snapshot.error.toString()),
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
