import 'dart:convert';

import 'package:epicture/bloc/applicationBloc.dart';
import 'package:epicture/bloc/bloc.dart';
import 'package:epicture/objects/OAuthAccessToken.dart';
import 'package:epicture/views/mainPage.dart';
import 'package:epicture/views/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPage.dart';

class LandingPage extends StatelessWidget {
  Future<bool> isLoggedIn(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final crendentialsString = prefs.getString("oauth_credentials");
    final applicationBloc = BlocProvider.of<ApplicationBloc>(context);

    if (crendentialsString == null)
      return true;
    try {
      final credentials = OAuthAccessToken.fromJson(jsonDecode(crendentialsString));
      applicationBloc.registerToken.add(credentials);
      print("logged in as: ${credentials.accountUsername}");
      return true;
    } catch (e) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (
       Builder(
        builder: (context) => FutureBuilder<bool>(
          future: isLoggedIn(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data)
                return MainPage();
              else
                return LoginPage();
            }
            return Splashscreen();
          },
        ),
      )
    );
  }
}
