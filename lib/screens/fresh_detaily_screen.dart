import 'package:flutter/material.dart';
import 'package:get_see/movie_model.dart';

class DetailedScreen extends StatelessWidget {
  static const routeName = '/detailed_screen';
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    MovieModel movie = data['Movie'];
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 30, 10, 10),
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
            ),
          ),
           Expanded(
             flex: 9,
             child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Image.network(
                      movie.photoPath,
                      fit: BoxFit.fitWidth,),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(movie.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),),
                    margin: EdgeInsets.only(left: 20, right: 20),
                  ),
                ),
                Container(
                  child: Divider(),
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Дата выхода: ${movie.releaseDate}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),),
                    margin: EdgeInsets.only(left: 20, right: 20),
                  ),
                ),
                Container(
                  child: Divider(),
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Средняя оценка пользователей: ${movie.voteAverage}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),),
                    margin: EdgeInsets.only(left: 20, right: 20),
                  ),
                ),
                Container(
                  child: Divider(),
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(movie.description??"No description",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
          ),
           ),
        ],
      ),
    );
  }
}
