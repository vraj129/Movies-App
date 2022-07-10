part of 'top_rated_bloc.dart';

@immutable
abstract class TopRatedEvent {}

class FetchMovies extends TopRatedEvent {
  FetchMovies();
}
