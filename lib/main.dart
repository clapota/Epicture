import 'package:epicture/bloc/bloc.dart';
import 'package:epicture/views/LandingPage.dart';
import 'package:epicture/views/splashscreen.dart';
import 'package:flutter/material.dart';
import 'objects/OAuthAccessToken.dart';
import 'package:uni_links/uni_links.dart';
import 'package:epicture/bloc/applicationBloc.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() => runApp(EpictureApp());

class EpictureApp extends StatelessWidget {
  // This widget is the root of your application.
  Future<bool> saveCredentials(Uri uri) async {
    print("saving credentials");
    print("credentials: ${jsonEncode(OAuthAccessToken.fromUri(uri))}");
    final prefs = await SharedPreferences.getInstance();
    try {
      return await prefs.setString("oauth_credentials", jsonEncode(OAuthAccessToken.fromUri(uri)));
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Widget> buildFromDeepLink(BuildContext context, Uri uri) async {
    print("DeepLink uri: $uri");
    if (uri.host == "login") {
      if (!await saveCredentials(uri))
        print("Error when logging in");
    }
    return LandingPage();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return BlocProvider<ApplicationBloc>(
        bloc: ApplicationBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              fontFamily: 'Nunito',
              primaryColor: Color(0xFFfbab66),
              primaryColorDark: Color(0xFFFF9F59),
              primaryColorLight: Color(0xFFFF9F59),
              accentColor: Color(0xFFFF9F59)),
          home: FutureBuilder<Uri>(
            future: () async {
              Uri uri;
              try {
                uri = await getInitialUri();
              } catch(e) {
                uri = null;
              }
              await Future.delayed(Duration(seconds: 3));
              return uri ?? Uri.parse("epicture://"); // gitan mais si on renvoie null ça bloque sur le splashscreen
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
                return FutureBuilder<Widget>(
                  future: buildFromDeepLink(context, snapshot.data),
                  builder: (context, snapshot) {
                    print("snapshot: $snapshot");
                    if (snapshot.hasData)
                      return snapshot.data;
                    return Splashscreen();
                  },
                );
              return Splashscreen();
            },
          ),
        )
    );
  }
}
