import 'package:movie_app/models/Now%20Playing%20Models/genre.dart';

class GenreJsonResponse {
  GenreJsonResponse({
    required this.genres,
  });

  List<Genre> genres;

  factory GenreJsonResponse.fromJson(Map<String, dynamic> json) =>
      GenreJsonResponse(
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
      };
}
