import 'package:epicture/views/splashscreen.dart';
import 'package:flutter/material.dart';
import 'objects/ImgurCredentials.dart';
import 'views/home.dart';
import 'package:uni_links/uni_links.dart';

void main() => runApp(EpictureApp());

class EpictureApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _EpictureAppState createState() => _EpictureAppState();
}

class _EpictureAppState extends State<EpictureApp> {

  Widget buildFromDeepLink(Uri uri) {
    if (uri == null)
      return HomeView();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'OpenSans',
          primaryColor: Color(0xFFfbab66),
          primaryColorDark: Color(0xFFFF9F59),
          primaryColorLight: Color(0xFFFF9F59),
          accentColor: Color(0xFFFF9F59)),
      home: FutureBuilder<Uri>(
        future: () async {
          final Uri uri = await getInitialUri();
          Future.delayed(Duration(seconds: 3));
          return uri;
        }(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Scaffold(
              body: Center(
                child: Text(
                  snapshot.error,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            );
          if (snapshot.hasData)
            return buildFromDeepLink(snapshot.data);
          return Splashscreen();
        },
      ),
    );
  }
}
