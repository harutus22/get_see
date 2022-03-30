import 'package:get_see/movie_model.dart';
import 'package:http/http.dart';
import 'dart:math';
import 'dart:convert';

class MovieApi{
  String _image_url = "https://image.tmdb.org/t/p/w500";
  String _random_movie = "https://api.themoviedb.org/3/movie/";
  String _api_key = "?api_key=fa1798331f5c3afde247ad332b4c1d98&language=ru";
  String _new_movies = "https://api.themoviedb.org/3/movie/now_playing?api_key=fa1798331f5c3afde247ad332b4c1d98&language=ru&page=";

  Future<MovieModel> getRandomMovie() async{
    MovieModel movie;
    try{

      Random random = new Random();
      int randomNumber = random.nextInt(80000);
      Response response = await get("$_random_movie$randomNumber$_api_key");
      Map data = jsonDecode(response.body);
      if(response.statusCode != 200)
        getRandomMovie();
      String image = _image_url + data['poster_path'];
      if(image == null)
        getRandomMovie();
      movie = MovieModel(id: data['id'], title: data['title']??null, photoPath: image,
          genre: "", description: data['overview']??null, budget: data['budget'].toString(),
          voteAverage: data['vote_average'].toString(), releaseDate: data["release_date"]);


    } catch (e){
      print('caught error: $e');
    }
    return Future.value(movie);
  }

  Future<List<MovieModel>> getNewMovies(int page) async{
    List<MovieModel> movies;
    try{
      Response response = await get("$_new_movies$page");
      if(response.statusCode != 200)
        getNewMovies(page);
      Map<String, dynamic> map = jsonDecode(response.body);
      List<dynamic> data = map["results"];
      movies = data.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch(e){
      print('caught error: $e');
    }
    return movies;
  }
}