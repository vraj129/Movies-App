part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent {}

class FetchMovies extends MoviesEvent {
  FetchMovies();
}
