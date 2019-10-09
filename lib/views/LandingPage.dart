import 'dart:convert';

import 'package:epicture/objects/OAuthAccessToken.dart';
import 'package:epicture/views/mainPage.dart';
import 'package:epicture/views/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPage.dart';

class LandingPage extends StatelessWidget {
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final credentials_string = prefs.getString("oauth_credentials");

    if (credentials_string == null) return false;
    try {
      final credentials = OAuthAccessToken.fromJson(jsonDecode(credentials_string));
      // TODO store credentials somewhere
      print("logged in as: ${credentials.accountUsername}");
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLoggedIn(),
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
}
