part of 'popular_bloc.dart';

@immutable
abstract class PopularState {}

class PopularInitial extends PopularState {}

class LoadedMovies extends PopularState {
  late final List<Result> resultList;
  late final List<Genre> genreList;
  LoadedMovies({required this.resultList, required this.genreList});
  List<Object> get props => [resultList];
  List<Object> get prop => [genreList];
}

class ErrorState extends PopularState {
  late final String message;
  ErrorState({required this.message});
  List<Object> get props => [message];
}
