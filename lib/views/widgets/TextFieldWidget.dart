import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({Key key, this.hintText, this.visible}) : super(key: key);

  final String hintText;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          hintText: this.hintText,
          hintStyle: TextStyle(color: Colors.white),
        ),
        obscureText: !visible,
        style: TextStyle(color: Colors.white),
      ),
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
    );
  }
}