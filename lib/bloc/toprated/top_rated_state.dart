part of 'top_rated_bloc.dart';

@immutable
abstract class TopRatedState {}

class TopRatedInitial extends TopRatedState {}

class LoadedMovies extends TopRatedState {
  late final List<Result> resultList;
  late final List<Genre> genreList;
  LoadedMovies({required this.resultList, required this.genreList});
  List<Object> get props => [resultList];
  List<Object> get prop => [genreList];
}

class ErrorState extends TopRatedState {
  late final String message;
  ErrorState({required this.message});
  List<Object> get props => [message];
}
