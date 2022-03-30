class MovieModel{
  int id;
  String title;
  String photoPath;
  String genre;
  String description;
  String budget;
  String voteAverage;
  String releaseDate;
  int isDeleted;

  MovieModel({this.id, this.title, this.photoPath, this.genre, this.description, this.budget, this.voteAverage, this.releaseDate, this.isDeleted = 1});

  MovieModel.empty();

  factory MovieModel.fromJson(dynamic json) {
    return MovieModel(id: json["id"], title: json["title"], photoPath: "https://image.tmdb.org/t/p/w500${json["backdrop_path"]}",
        genre: "", description: json["overview"], budget: "",
        voteAverage: json["vote_average"].toString(), releaseDate: json["release_date"], isDeleted: 1);
  }

  @override
  String toString() {
    // TODO: implement toString
    return "{${this.id} ${this.title} ${this.photoPath} ${this.genre} ${this.description}"
       + " ${this.budget} ${this.voteAverage} ${this.releaseDate} }";
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'picture_path': photoPath,
      'genre': genre,
      'description': description,
      'budget': budget,
      'voteAverage': voteAverage,
      'releaseDate': releaseDate,
      'isDeleted' : isDeleted
    };
  }

}