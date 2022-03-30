import 'package:get_see/movie_model.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBHelper{
  static Database db_instance;

  static final table = 'new_table';

  static final DATABASE_NAME = "MOVIE_LIST.db";

  static final columnId = 'id';
  static final columnTitle = 'title';
  static final columnPicture = 'picture_path';
  static final columnGenre = 'genre';
  static final columnDescription = 'description';
  static final columnBudget = 'budget';
  static final columnVote = 'voteAverage';
  static final columnDate = 'releaseDate';
  static const isDeleted = 'isDeleted';

  Future<Database> get db async{
    if(db_instance == null) {
      db_instance =  await initDB();
    } else {
      return db_instance;
    }
  }

  initDB() async {
    io.Directory documnetDirectory = await getApplicationDocumentsDirectory();
    String path = join(documnetDirectory.path, DATABASE_NAME);
    var db = openDatabase(path, version: 1, onCreate: onCreateFunc);
    return db;
  }

  void onCreateFunc(Database db, int version) async {
    await db.execute('CREATE TABLE $table ($columnId INTEGER PRIMARY KEY, $columnTitle TEXT, $columnPicture TEXT, $columnGenre TEXT, $columnDescription TEXT, $columnBudget TEXT, $columnVote TEXT, $columnDate TEXT, $isDeleted INTEGER)');
  }

  Future<List<MovieModel>> getMovies() async {
    var db_connection = await db;
    List<Map> list = await db_connection.rawQuery('SELECT * FROM $table');
    List<MovieModel> movies = List();
    for (int i = 0; i < list.length; i++) {
      MovieModel movie = MovieModel.empty();
      movie.id = list[i]['$columnId'];
      movie.title = list[i]['$columnTitle'];
      movie.photoPath = list[i]['$columnPicture'];
      movie.genre = list[i]['$columnGenre'];
      movie.description = list[i]['$columnDescription'];
      movie.budget = list[i]['$columnBudget'];
      movie.voteAverage = list[i]['$columnVote'];
      movie.releaseDate = list[i]['$columnDate'];
      movie.isDeleted = list[i]['$isDeleted'];

      movies.add(movie);
    }
    return movies;
  }

  void addNewMovie(MovieModel movie) async {
    var connection = await db;
    // String query = 'INSERT INTO $table($columnId, $columnTitle, $columnPicture, $columnGenre, $columnBudget, $columnVote, $columnDate, $isDeleted) VALUES(${movie.id}, "${movie.title}", ${movie.photoPath}, "${movie.genre}", "${movie.description}", "${movie.budget}", "${movie.voteAverage}", "${movie.releaseDate}", ${movie.isDeleted})';
    final sql = 'INSERT INTO $table($columnId, $columnTitle, $columnPicture, $columnGenre, $columnDescription, $columnBudget, $columnVote, $columnDate, $isDeleted) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)';
    List<dynamic> params = [movie.id, '${movie.title}', '${movie.photoPath}', '${movie.genre}', '${movie.description}', '${movie.budget}', '${movie.voteAverage}', '${movie.releaseDate}', '${movie.isDeleted}'];
    await connection.transaction((transaction) async {
      return await transaction.rawInsert(sql, params);
    });
  }

  void deleteMovie(MovieModel movieModel) async {
    var connection = await db;
    String query = 'DELETE FROM $table WHERE id=${movieModel.id}';
    await connection.transaction((transiction) async {
      return await transiction.rawQuery(query);
    });
  }
}