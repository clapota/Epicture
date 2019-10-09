import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'objects/ImgurImage.dart';


class ImgurAPI {
  static final ImgurAPI _instance = new ImgurAPI._internal();

  static final clientId = "883372d5794f879";
  static final clientSecret = "a192dda0bde94551b8d0334f701573362664fd9e";
  static final authorizationEndpoint = Uri.parse("https://api.imgur.com/oauth2/authorize");
  static final tokenEndpoint = Uri.parse("https://api.imgur.com/oauth2/token");

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
    return _buildRequest("post", "/upload", queryParams: {}).send().then((response) async {
      return ImgurImage.fromJsonMap(jsonDecode(await response.stream.bytesToString()));
    });
  }
}
