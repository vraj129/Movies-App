import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:movie_app/Hive/boxes.dart';
import 'package:movie_app/bloc/toprated/top_rated_bloc.dart';
import 'package:movie_app/models/Now%20Playing%20Models/genre.dart';

class TopRated extends StatefulWidget {
  const TopRated({super.key});

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  late TopRatedBloc moviesBloc;
  bool isGenreLoaded = false;
  late String finalGenre;
  final box = Boxes.getData();

  @override
  void initState() {
    super.initState();
    moviesBloc = BlocProvider.of<TopRatedBloc>(context, listen: false);
    moviesBloc.add(FetchMovies());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Hive.box('favourite_movie').close();
    super.dispose();
  }

  void getGenres(List<int> results, List<Genre> genre) {
    finalGenre = '';
    String genres = '';
    for (int i = 0; i < results.length; i++) {
      for (int j = 0; j < genre.length; j++) {
        if (results[i] == genre[j].id) {
          genres += '${genre[j].name} ';
          break;
        }
      }
    }
    finalGenre = genres;
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('dd-MMM-yyyy');
    return Scaffold(
      body: BlocBuilder<TopRatedBloc, TopRatedState>(
        builder: (context, state) {
          if (state is LoadedMovies) {
            return ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, box, _) {
                  return LazyLoadScrollView(
                    onEndOfPage: () {
                      moviesBloc.add(FetchMovies());
                    },
                    scrollOffset: 70,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        getGenres(
                            state.resultList[index].genre_ids, state.genreList);
                        String date = state.resultList[index].release_date;
                        DateTime dt = DateTime.parse(date);
                        return Card(
                          elevation: 4,
                          shadowColor: Colors.grey.shade400,
                          child: Row(
                            children: [
                              ImageNetwork(
                                image:
                                    "https://image.tmdb.org/t/p/original${state.resultList[index].poster_path}",
                                imageCache: CachedNetworkImageProvider(
                                    "https://image.tmdb.org/t/p/original${state.resultList[index].poster_path}"),
                                height: 200,
                                width: 150,
                                duration: 1500,
                                curve: Curves.easeIn,
                                onPointer: true,
                                debugPrint: false,
                                fullScreen: false,
                                fitAndroidIos: BoxFit.cover,
                                fitWeb: BoxFitWeb.cover,
                                onError: const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.resultList[index].original_title,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(finalGenre),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(format.format(dt)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellowAccent,
                                          ),
                                          Text(state
                                              .resultList[index].vote_average
                                              .toString()),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Icon(
                                            Icons.thumb_up,
                                            color: Colors.green,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            state.resultList[index].vote_count
                                                .toString(),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          IconButton(
                                            icon: Icon(box.containsKey(state
                                                    .resultList[index]
                                                    .original_title)
                                                ? Icons.favorite
                                                : Icons.favorite_border),
                                            color: Colors.red,
                                            onPressed: () {
                                              if (box.containsKey(state
                                                  .resultList[index]
                                                  .original_title)) {
                                                box.delete(state
                                                    .resultList[index]
                                                    .original_title);
                                              } else {
                                                box.put(
                                                    state.resultList[index]
                                                        .original_title,
                                                    state.resultList[index]);
                                              }
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: state.resultList.length,
                    ),
                  );
                });
          } else if (state is ErrorState) {
            return Center(
              child: Text(state.message),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
