part of 'movies_bloc.dart';

@immutable
abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class LoadedMovies extends MoviesState {
  late final List<Result> resultList;
  late final List<Genre> genreList;
  LoadedMovies({required this.resultList, required this.genreList});
  List<Object> get props => [resultList];
  List<Object> get prop => [genreList];
}

class ErrorState extends MoviesState {
  late final String message;
  ErrorState({required this.message});
  List<Object> get props => [message];
}
