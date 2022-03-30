import 'package:flutter/material.dart';
import 'package:get_see/heart.dart';
import 'package:get_see/movie_model.dart';
import 'package:get_see/random_movie.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RandomScreen extends StatefulWidget {
  static const routeName = '/random_screen';

  @override
  _RandomScreenState createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {

  bool isFavourite = false;
  String heart = "assets/images/heart_no.png";
  final scafoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return FutureBuilder<MovieModel>(
      future: getRandomMovie(),
      builder: (context, data){
        if( data.connectionState == ConnectionState.waiting){
          return  Scaffold(
            key: scafoldKey,
            backgroundColor: Colors.white,
            body: Center(
              child: SpinKitFadingCube(
                color: Colors.black,
                size: 50.0,
              ),),
          );
        } else
       return Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 20),
                            child: GestureDetector(
                              child: SizedBox(
                                  child: Image.asset("assets/images/back.png"),
                                  height: 40),
                              onTap: (){
                                Navigator.pop(context);
                              },
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Heart(movie: data.data, isFavorite: false,),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              child: SizedBox(
                                child: Image.asset("assets/images/more.png"),
                                height: 40,),
                              onTap: (){
                                isFavourite = false;
                                getRandomMovie();
                                setState(() {

                                });
                              },
                            ),
                          ))
                    ],

                  ),
                ),
              ),
              Expanded(flex: 1, child: Container(
                padding: EdgeInsets.all(5),
                child: Text(data.data.title??"No title",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                  ),),
              ),
              ),
              Expanded(
                  child: Image.network(data.data.photoPath), flex: 4),
              SizedBox(height: 10),
              Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(data.data.description??"No description",
                          textAlign: TextAlign.center,
                      ),
                    ),
                  ))
            ],
          ),
      );
      },
    );
  }

  Future<MovieModel> getRandomMovie() async{
     MovieApi movie = MovieApi();
    MovieModel mo = await movie.getRandomMovie();
    if(mo == null)
      return getRandomMovie();
    else
     return Future.value(mo);
  }
}
