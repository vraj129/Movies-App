import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:movie_app/Hive/boxes.dart';
import 'package:movie_app/models/Now%20Playing%20Models/GenreJsonResponse.dart';
import 'package:movie_app/models/Now%20Playing%20Models/JSONResponse.dart';
import 'package:movie_app/models/Now%20Playing%20Models/Result.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/Now%20Playing%20Models/genre.dart';

class MovieRepo {
  Future<List<Result>?> getData(String page) async {
    try {
      final url = Uri.https(
        'api.themoviedb.org',
        '/3/movie/now_playing',
        {'page': page, 'api_key': '0e7274f05c36db12cbe71d9ab0393d47'},
      );
      final response = await http.get(url);
      final json = jsonDecode(response.body);
      JSONResponse jsonResponse = JSONResponse.fromJson(json);
      List<Result> resultList = [];
      resultList.addAll(jsonResponse.results);
      return resultList.isEmpty ? null : resultList;
    } catch (err) {
      return null;
    }
  }

  Future<List<Genre>?> getGenre() async {
    try {
      List<Genre> genreList = [];
      final url = Uri.https(
        'api.themoviedb.org',
        '/3/genre/movie/list',
        {'api_key': '0e7274f05c36db12cbe71d9ab0393d47'},
      );
      final response = await http.get(url);
      final json = jsonDecode(response.body);
      GenreJsonResponse genreJsonResponse = GenreJsonResponse.fromJson(json);
      genreList.addAll(genreJsonResponse.genres);
      return genreList.isEmpty ? null : genreList;
    } catch (err) {
      return null;
    }
  }

  Future<List<Result>?> getPopular(String page) async {
    try {
      final url = Uri.https(
        'api.themoviedb.org',
        '/3/movie/popular',
        {'page': page, 'api_key': '0e7274f05c36db12cbe71d9ab0393d47'},
      );

      final response = await http.get(url);

      final json = jsonDecode(response.body);
      JSONResponse jsonResponse = JSONResponse.fromJson(json);
      List<Result> resultList = [];
      resultList.addAll(jsonResponse.results);
      return resultList.isEmpty ? null : resultList;
    } catch (err) {
      return null;
    }
  }

  Future<List<Result>?> getTopRated(String page) async {
    try {
      final url = Uri.https(
        'api.themoviedb.org',
        '/3/movie/top_rated',
        {'page': page, 'api_key': '0e7274f05c36db12cbe71d9ab0393d47'},
      );
      final response = await http.get(url);
      final json = jsonDecode(response.body);
      JSONResponse jsonResponse = JSONResponse.fromJson(json);
      List<Result> resultList = [];

      resultList.addAll(jsonResponse.results);

      return resultList.isEmpty ? null : resultList;
    } catch (err) {
      return null;
    }
  }
}
