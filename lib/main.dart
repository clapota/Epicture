import 'package:flutter/material.dart';
import 'package:epicture/views/scrollableImgur.dart';
import 'views/home.dart';

void main() => runApp(EpictureApp());

class EpictureApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: Color(0xFFfbab66),
        primaryColorDark: Color(0xFFFF9F59),
        primaryColorLight: Color(0xFFFF9F59),
        accentColor: Color(0xFFFF9F59)
      ),
      home: HomeView(),
      );
  }
}