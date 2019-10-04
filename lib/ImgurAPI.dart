import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth;
import 'objects/ImgurImage.dart';

class OAuth {
  static final String client_id = "";
  static final String client_secret = "";

}

class ImgurAPI {
  static final ImgurAPI _instance = new ImgurAPI._internal();

  factory ImgurAPI() {
    return _instance;
  }

  ImgurAPI._internal();

  final String baseUrl = "api.imgur.com";
  final int version = 3;
  String auth;

  http.Request _buildRequest(String method, String path, {Map<String, dynamic> queryParams = const {}}) {
    return http.Request(
      method,
      Uri(
        scheme: "https",
        host: "$baseUrl/$version",
        path: path,
        queryParameters: {}..addAll(queryParams),
      ),
    );
  }

  Future<ImgurImage> postImage(var image) async {
    return _buildRequest("post", "/upload", queryParams: {
    }).send().then((response) async {
      return ImgurImage.fromJsonMap(jsonDecode(await response.stream.bytesToString()));
    });
  }
}
