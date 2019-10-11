import 'dart:convert';

import 'package:epicture/objects/OAuthAccessToken.dart';
import 'package:epicture/views/mainPage.dart';
import 'package:epicture/views/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:epicture/models/TokenModel.dart';

class LandingPage extends StatelessWidget {
  Future<bool> isLoggedIn(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final credentials_string = prefs.getString("oauth_credentials");

    if (credentials_string == null) return true;
    try {
      final credentials = OAuthAccessToken.fromJson(jsonDecode(credentials_string));
      ScopedModel.of<TokenModel>(context).storeToken(credentials);
      print("logged in as: ${credentials.accountUsername}");
      return true;
    } catch (e) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<TokenModel>(
      model: new TokenModel(),
      child: Builder(
        builder: (context) {
          return FutureBuilder<bool>(
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
          );
        }
      )

    );
  }
}
