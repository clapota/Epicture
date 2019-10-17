import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:epicture/objects/Comment.dart';
import 'package:epicture/objects/ImgurTag.dart';
import 'package:epicture/objects/OAuthAccessToken.dart';
import 'package:epicture/objects/test.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  http.Request _buildRequest(String method, String path, {Map<String, dynamic> queryParams = const {}, Map<String, dynamic> headers = const {}}) {
    return http.Request(
      method,
      Uri(
        scheme: "https",
        host: "$baseUrl",
        path: "/$version/$path",
        queryParameters: {}..addAll(queryParams),
      ),
    );
  }

  Future<ImgurImage> postImage(var image) async {
    //TODO
    return _buildRequest("post", "/upload", queryParams: {}).send().then((response) async {
      return ImgurImage.fromJsonMap(jsonDecode(await response.stream.bytesToString()));
    });
  }

  Future<List<ImgurTag>> getTags() async {
    return http.get(
      "https://$baseUrl/$version/tags",
      headers: {HttpHeaders.authorizationHeader: "Client-ID " + clientId}).then((response) async {
        return (jsonDecode(response.body)['data']['tags'] as List<dynamic>).map((it) => ImgurTag.fromJson(it)).toList();
    });
  }

  String getImageFromHash(String hash) {
    return "https://i.imgur.com/$hash.jpg";
  }

  Future<List<GalleryAlbum>> getImagesFromTag(String tag, {int page = 1, String category = 'top'}) async {
    final String pageString = page.toString();
    return http.get(
      "https://$baseUrl/$version/gallery/t/$tag/$category/$pageString",
      headers: {HttpHeaders.authorizationHeader: "Client-ID " + clientId}).then((response) async {
        List<dynamic> toto = (jsonDecode(response.body)['data']['items'] as List<dynamic>);
        return toto.map((it) => GalleryAlbum.fromJson(it)).toList();
      }
    );
  }

  Future<List<Comment>> getCommentsFromId(String id) {
    final String route = "https://$baseUrl/$version/gallery/$id/comments/best";
    return http.get(
      route,
      headers: {HttpHeaders.authorizationHeader: "Client-ID " + clientId}).then((response) async {
        List<dynamic> toto = (jsonDecode(response.body)['data'] as List<dynamic>);

        return toto.map((it) => Comment.fromJson(it)).toList();
      });
  }

  Future<int> addFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    OAuthAccessToken token;
    try {
      dynamic credentials = prefs.getString('oauth_credentials');
      token = OAuthAccessToken.fromJson(jsonDecode(credentials));
    } catch (e) {
      return 400;
    }
    debugPrint(token.refreshToken);
    final String route = "https://$baseUrl/$version/album/$id/favorite";

    return http.post(
      route,
      headers: {HttpHeaders.authorizationHeader: "Bearer " + token.accessToken}).then((response) async {
        dynamic toto = (jsonDecode(response.body) as dynamic);

        debugPrint(toto.toString());
        return toto['status'];
    });
  }

  String getImageThumbnail(String url) {
    return "https://i.imgur.com/${Uri.parse(url).path.replaceFirst(".", "m.")}";
  }
}