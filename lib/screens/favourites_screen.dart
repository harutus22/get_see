import 'package:flutter/material.dart';
import 'package:get_see/db_helper.dart';
import 'package:get_see/heart.dart';
import 'package:get_see/movie_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class FavouriteScreen extends StatefulWidget {
  static const routeName = '/fav_screen';

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final _formKey = GlobalKey<FormState>();
  var db = DBHelper();

  @override
  initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
        future: db.getMovies(),
        // ignore: missing_return
        builder: (context, snapshot) {
          // return Image.network(snapshot.data[3].photoPath);
          if(snapshot.connectionState == ConnectionState.waiting){
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: SpinKitFadingCube(
                  color: Colors.black,
                  size: 50.0,
                ),),
            );;
          }
          else if(snapshot.connectionState == ConnectionState.done){
            return Scaffold(
              body: Column(
                children: [
                  Container(
                    height: 80,
                    margin: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                        child: SizedBox(
                            child: Image.asset(
                                "assets/images/back.png"),
                            height: 40),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Divider(
                    height: 20,
                    indent: 30,
                    endIndent: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, position) {
                          return Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Heart(movie: snapshot.data[position], isFavorite: true,)),
                                    ),
                                  ],

                                ),
                                Container(
                                  padding: EdgeInsets.all(14),
                                  child: Text(snapshot.data[position].title ?? "No title",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 26,
                                    ),),
                                ),
                                Image.network(
                                    snapshot.data[position].photoPath),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(snapshot.data[position].description ??
                                        "No description",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                    ),
                  ),
                ],
              )
            );
          }
        });
  }
}

