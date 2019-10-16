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
    print('vive le caca');
    final prefs = await SharedPreferences.getInstance();
    final crendentialsString = prefs.getString("oauth_credentials");
    final applicationBloc = BlocProvider.of<ApplicationBloc>(context);

    if (crendentialsString == null)
      return false;
    try {
      print('le zizi');
      final credentials = OAuthAccessToken.fromJson(jsonDecode(crendentialsString));
//      ScopedModel.of<TokenModel>(context).storeToken(credentials);
      applicationBloc.registerToken.add(credentials);
      print("logged in as: ${credentials.accountUsername}");
      return true;
    } catch (e) {
      return false;
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
