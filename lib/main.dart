import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/bloc/movies_bloc.dart';
import 'package:movie_app/bloc/popular/popular_bloc.dart';
import 'package:movie_app/bloc/toprated/top_rated_bloc.dart';
import 'package:movie_app/models/Now%20Playing%20Models/genre.dart';
import 'package:movie_app/screens/favourite.dart';
import 'package:movie_app/screens/nowplaying.dart';
import 'package:movie_app/screens/popular.dart';
import 'package:movie_app/screens/toprated.dart';

import 'models/Now Playing Models/Result.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ResultAdapter());
  await Hive.openBox<Result>('favourite_movie');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Movie App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  final screens = [
    const NowPlaying(),
    const Popular(),
    const TopRated(),
    Favourite(),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MoviesBloc(),
          child: const NowPlaying(),
        ),
        BlocProvider(
          create: (context) => PopularBloc(),
          child: const Popular(),
        ),
        BlocProvider(
          create: (context) => TopRatedBloc(),
          child: const TopRated(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              label: 'Now Playing',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.badge),
              label: 'Popular',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Top Rated',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourites',
              backgroundColor: Colors.cyan,
            ),
          ],
        ),
      ),
    );
  }
}
