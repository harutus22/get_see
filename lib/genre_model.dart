class Genre{
  String id;
  String genre;

  Genre({this.id, this.genre});

  factory Genre.fromJson(Map<int, dynamic> json){
    return Genre(
      id: json['id'],
      genre: json['name']
    );
  }
}