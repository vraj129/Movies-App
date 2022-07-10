import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/Hive/boxes.dart';
import 'package:movie_app/models/Now%20Playing%20Models/Result.dart';

class Favourite extends StatelessWidget {
  final Box box = Boxes.getData();
  //final Box box1 = Boxes.getGenreData();

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('dd-MMM-yyyy');
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, box, child) {
            List<Result> resultList = List.from(box.values);
            return ListView.separated(
              itemBuilder: (context, index) {
                String date = resultList[index].release_date;
                DateTime dt = DateTime.parse(date);
                return Card(
                  elevation: 4,
                  shadowColor: Colors.grey.shade400,
                  child: Row(
                    children: [
                      ImageNetwork(
                        image:
                            "https://image.tmdb.org/t/p/original${resultList[index].poster_path}",
                        imageCache: CachedNetworkImageProvider(
                            "https://image.tmdb.org/t/p/original${resultList[index].poster_path}"),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resultList[index].original_title,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold),
                              ),
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
                                  Text(resultList[index]
                                      .vote_average
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
                                    resultList[index].vote_count.toString(),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      box.delete(
                                          resultList[index].original_title);
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
              itemCount: resultList.length,
            );
          }),
    );
  }
}
