import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/models/Now%20Playing%20Models/Result.dart';
import 'package:movie_app/models/Now%20Playing%20Models/genre.dart';
import 'package:movie_app/repositores/movie_repo.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  PopularBloc() : super(PopularInitial()) {}
  MovieRepo movieRepo = MovieRepo();
  List<Result> resultList = [];
  List<Genre> genreList = [];
  int page = 0;
  bool isLoading = false;
  @override
  Stream<PopularState> mapEventToState(PopularEvent event) async* {
    if (event is FetchMovies) {
      if (!isLoading) {
        isLoading = true;
        try {
          List<Genre>? glist = await movieRepo.getGenre();
          if (glist?.length != null) {
            page++;
            List<Result>? list = await movieRepo.getPopular(page.toString());
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
          yield ErrorState(message: e.toString());
        }
        isLoading = false;
      }
    }
  }
}
