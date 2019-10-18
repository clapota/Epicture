import 'package:epicture/objects/Comment.dart';
import 'package:epicture/views/CommentView.dart';
import 'package:epicture/views/widgets/FadeRoute.dart';
import 'package:epicture/views/widgets/PressableIconWidget.dart';
import 'package:flutter/material.dart';


class CommentWidget extends StatefulWidget {
  CommentWidget({Key key, this.comment, this.color = Colors.grey}) : super(key: key);

  final Comment comment;
  final Color color;

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}


class _CommentWidgetState extends State<CommentWidget> {

  void doNothing() {}

  void likeComment() {
    //TODO
  }

  void dislikeComment() {
    //TODO
  }

  void showReplies() {
    Navigator.push(context, FadeRoute(page: CommentView(parent: this.widget.comment,)));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: Column(
        children: <Widget>[
          Text(this.widget.comment.comment, style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w800), textAlign: TextAlign.center,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(this.widget.comment.author + ' • 4hr', style: TextStyle(fontSize: 10.0, color: Colors.white, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
            ],
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                PressableIconWidget(iconData: Icons.thumb_up, pressedColor: Colors.lightBlue, onClick: this.likeComment, label: this.widget.comment.ups.toString(),),
                PressableIconWidget(iconData: Icons.thumb_down, pressedColor: Colors.black, onClick: this.dislikeComment, label: this.widget.comment.downs.toString(),),
                PressableIconWidget(iconData: Icons.comment, onClick: this.widget.comment.children != null && this.widget.comment.children.length > 0 ? this.showReplies : doNothing, pressedColor: Colors.white,label: this.widget.comment.children == null ? '0' : this.widget.comment.children.length.toString(),)
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