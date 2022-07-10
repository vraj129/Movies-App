import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/models/Now%20Playing%20Models/Result.dart';
import 'package:movie_app/models/Now%20Playing%20Models/genre.dart';
import 'package:movie_app/repositores/movie_repo.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  TopRatedBloc() : super(TopRatedInitial()) {}
  MovieRepo movieRepo = MovieRepo();
  List<Result> resultList = [];
  List<Genre> genreList = [];
  int page = 0;
  bool isLoading = false;
  @override
  Stream<TopRatedState> mapEventToState(TopRatedEvent event) async* {
    if (event is FetchMovies) {
      if (!isLoading) {
        isLoading = true;
        try {
          List<Genre>? glist = await movieRepo.getGenre();
          if (glist?.length != null) {
            page++;
            List<Result>? list = await movieRepo.getTopRated(page.toString());
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
