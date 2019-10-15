import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:epicture/objects/ImgurTag.dart';
import 'package:epicture/objects/test.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
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

  Future<Image> getImageFromHash(String hash) async {
    return Image.network("https://i.imgur.com/$hash.jpg");
  }

  Future<List<GalleryAlbum>> getImagesFromTag(String tag, {int page = 1, String category = 'top'}) async {
    final String pageString = page.toString();
    debugPrint("https://$baseUrl/$version/gallery/t/$tag/$category/$pageString");
    return http.get(
      "https://$baseUrl/$version/gallery/t/$tag/$category/$pageString",
      headers: {HttpHeaders.authorizationHeader: "Client-ID " + clientId}).then((response) async {
        List<dynamic> toto = (jsonDecode(response.body)['data']['items'] as List<dynamic>);
        debugPrint('ALOUDR A' + 'zizi');
        return toto.map((it) => GalleryAlbum.fromJson(it)).toList();
      }
    );
  }
}