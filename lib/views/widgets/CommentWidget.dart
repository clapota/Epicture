import 'package:epicture/objects/Comment.dart';
import 'package:epicture/views/widgets/PressableIconWidget.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key key, this.comment, this.color = Colors.grey}) : super(key: key);

  final Comment comment;
  final Color color;

  void likeComment() {
    //TODO
  }

  void dislikeComment() {
    //TODO
  }

  void showReplies() {
    //TODO
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: Column(
        children: <Widget>[
          Text(this.comment.comment, style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w800), textAlign: TextAlign.center,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(this.comment.author + ' • 4hr', style: TextStyle(fontSize: 10.0, color: Colors.white, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
            ],
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                PressableIconWidget(iconData: Icons.thumb_up, pressedColor: Colors.lightBlue, onClick: this.likeComment, label: this.comment.ups.toString(),),
                PressableIconWidget(iconData: Icons.thumb_down, pressedColor: Colors.black, onClick: this.dislikeComment, label: this.comment.downs.toString(),),
                PressableIconWidget(iconData: Icons.comment, onClick: this.showReplies, label: 'A faire',)
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [Color(0xFFFD60A3), Color(0xFFFF8961)],
          stops: const [0.0, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight
        ),
        border: Border(bottom: BorderSide(color: Colors.white, width: 1.0)
      ),
//      color: this.color,
    )
    ));
  }
}