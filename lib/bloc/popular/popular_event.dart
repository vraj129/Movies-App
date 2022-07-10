part of 'popular_bloc.dart';

@immutable
abstract class PopularEvent {}

class FetchMovies extends PopularEvent {
  FetchMovies();
}
