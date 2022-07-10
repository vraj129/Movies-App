import 'package:hive/hive.dart';

part 'Result.g.dart';

@HiveType(typeId: 0)
class Result extends HiveObject {
  @HiveField(0)
  final List<int> genre_ids;
  @HiveField(1)
  final String original_title;
  @HiveField(2)
  final String overview;
  @HiveField(3)
  final String poster_path;
  @HiveField(4)
  final String release_date;
  @HiveField(5)
  final double vote_average;
  @HiveField(6)
  final int vote_count;

  Result(
      {required this.genre_ids,
      required this.original_title,
      required this.overview,
      required this.poster_path,
      required this.release_date,
      required this.vote_average,
      required this.vote_count});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      genre_ids: parseGenre(json['genre_ids']),
      original_title: json["original_title"],
      overview: json["overview"],
      poster_path: json["poster_path"],
      release_date: json["release_date"],
      vote_average: json["vote_average"].toDouble(),
      vote_count: json["vote_count"],
    );
  }

  static List<int> parseGenre(genreJson) {
    List<int> genreList = List<int>.from(genreJson);
    return genreList;
  }
}
