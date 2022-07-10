import 'package:hive/hive.dart';
import 'package:movie_app/models/Now%20Playing%20Models/Result.dart';
import 'package:movie_app/models/Now%20Playing%20Models/genre.dart';

class Boxes {
  static Box<Result> getData() => Hive.box('favourite_movie');
}
