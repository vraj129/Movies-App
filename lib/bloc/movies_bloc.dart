import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/Hive/boxes.dart';
import 'package:movie_app/models/Now%20Playing%20Models/Result.dart';

import 'package:movie_app/repositores/movie_repo.dart';

import '../models/Now Playing Models/genre.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial());
  MovieRepo movieRepo = MovieRepo();
  List<Result> resultList = [];
  List<Genre> genreList = [];
  int page = 0;
  bool isLoading = false;
  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if (event is FetchMovies) {
      if (!isLoading) {
        isLoading = true;
        try {
          List<Genre>? glist = [];
          glist = await movieRepo.getGenre();
          if (glist?.length != null) {
            page++;
            List<Result>? list = await movieRepo.getData(page.toString());
            if (list == null) {
              page--;
              yield ErrorState(message: 'Failed To Fetch Movies');
            } else {
              genreList.addAll(glist!);
              resultList.addAll(list);
              yield LoadedMovies(resultList: resultList, genreList: genreList);
            }
          } else {
            yield ErrorState(message: 'Failed To Fetch Movies');
          }
        } catch (e) {
          page--;
          print(e.toString());
          yield ErrorState(message: e.toString());
        }
        isLoading = false;
      }
    }
  }
}
