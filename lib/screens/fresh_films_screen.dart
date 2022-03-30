import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_see/movie_model.dart';
import 'package:get_see/random_movie.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_see/screens/fresh_detaily_screen.dart';


class FreshFilmsScreen extends StatefulWidget {
  static const routeName = '/fresh_screen';

  @override
  _FreshFilmsScreenState createState() => _FreshFilmsScreenState();
}

class _FreshFilmsScreenState extends State<FreshFilmsScreen> {
  List<MovieModel> _movies;
  int _page = 1;
  var _controller = ScrollController(
    keepScrollOffset: true
  );
  bool _first_init = false;
  GlobalKey<RefreshIndicatorState> refresh_key;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresh_key = GlobalKey<RefreshIndicatorState>();
    _movies = List<MovieModel>();
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        // if (_controller.position.maxScrollExtent == _controller.offset)

    }

    });
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: getFreshMovie(_page),
        builder: (context, data) {
          if (!_first_init && data.connectionState == ConnectionState.waiting) {
            _first_init = true;
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: SpinKitFadingCube(
                  color: Colors.black,
                  size: 50.0,
                ),),
            );
          } else if (data.connectionState == ConnectionState.done) {
            return RefreshIndicator(
              key: ObjectKey(refresh_key),
              onRefresh: () async {
                await getNextMovies();
                setState(() {});
              },
              child: Scaffold(
                body: Column(
                  children: [
                    Expanded(child: Container(
                      margin: EdgeInsets.fromLTRB(30, 0, 10, 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          child: Container(height: 40,
                              width: 40, child: Image.asset(
                                  "assets/images/back.png")),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ), flex: 1,),
                    Expanded(flex: 8,
                      child: ListView.builder(
                          itemCount: _movies.length, controller: _controller,
                          itemBuilder: (context, position) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, DetailedScreen.routeName, arguments: {
                                  'Movie' : _movies[position],
                                });
                              }
                              , child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                  child: Image.network(
                                    _movies[position].photoPath,
                                    fit: BoxFit.fitWidth,),
                                ),
                                Container(
                                  child: Text("фильм: ${_movies[position]
                                      .title} /дата выхода:  ${_movies[position]
                                      .releaseDate}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),),
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                ),
                                Container(
                                  child: Divider(),
                                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                )
                              ],
                            ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(

            );
          }
        });
  }

  Future<List<MovieModel>> getFreshMovie(int page) async {
    MovieApi movie = MovieApi();
    _movies.addAll(await movie.getNewMovies(page));
    if (_movies == null)
      return getFreshMovie(page);
    else
      return Future.value(_movies);
  }

  Future<void> getNextMovies() async {
    _page++;
    MovieApi movie = MovieApi();
    _movies.insertAll(0, await movie.getNewMovies(_page));
  }

}
