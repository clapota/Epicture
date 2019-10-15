import 'package:epicture/ImgurAPI.dart';
import 'package:epicture/objects/Comment.dart';
import 'package:epicture/objects/test.dart';
import 'package:flutter/material.dart';
import 'package:epicture/views/widgets/CommentWidget.dart';

class CommentView extends StatefulWidget {
  CommentView({Key key, this.album}) : super(key: key);

  final GalleryAlbum album;
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {

  Future<List<Comment>> fetchComment() async {
    final api = ImgurAPI();

    List<Comment> comments = await api.getCommentsFromId(this.widget.album.id);

    return comments;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Comment>>(
      future: fetchComment(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
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
              Text('Error '  + snapshot.error.toString()),
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}