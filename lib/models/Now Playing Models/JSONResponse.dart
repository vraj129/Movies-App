import 'package:movie_app/models/Now%20Playing%20Models/Result.dart';

class JSONResponse {
  final List<Result> results;

  JSONResponse({required this.results});

  factory JSONResponse.fromJson(Map<String, dynamic> json) => JSONResponse(
        results: parseResults(json),
      );

  static List<Result> parseResults(resultsJson) {
    var list = resultsJson['results'] as List;
    List<Result> resultList =
        list.map((data) => Result.fromJson(data)).toList();
    return resultList;
  }
}
