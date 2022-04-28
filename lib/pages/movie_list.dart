import 'package:flutter/material.dart';
import 'package:flutter_http/service/http_service.dart';
import 'movie_detail.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late int moviesCount;
  late List movies;
  late HttpService service;
  bool _isLoading = true;

  Future initialize() async {
    movies = [];
    movies = (await service.getPopularMovies())!;
    setState(() {
      moviesCount = movies.length;
      movies = movies;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Popular Movies - Dike Ayu 2031710147"),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: (moviesCount == null) ? 0 : moviesCount,
                itemBuilder: (context, int position) {
                  return Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: ListTile(
                        title: Text(movies[position].title),
                        subtitle: Text(
                          'Rating = ' + movies[position].voteAverage.toString(),
                        ),
                        onTap: () {
                          MaterialPageRoute route = MaterialPageRoute(
                              builder: (_) => MovieDetail(movies[position]));
                          Navigator.push(context, route);
                        }),
                  );
                },
              ));
  }
}
