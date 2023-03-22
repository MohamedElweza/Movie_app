class Movie{

  late int rank;
  late String title;
  late String thumbnail;
  late String rating;
  late String id;
  late int year;
  late String image;
  late String description;
  late String trailer;
  late List<String> genre;
  late List<String> director;
  late List<String> writers;
  late String imdbid;

  Movie.fromMap(Map<String, dynamic> map){

    this.rank = map['rank'];

    this.title = map['title'];

    this.thumbnail = map['thumbnail'];

    this.rating = map['rating'];

    this.id = map['id'];

    this.year = map['year'];

    this.image = map['image'];

    this.description = map['description'];

    this.trailer = map['trailer'];

    this.genre = [];
      map['genre'].forEach((e){
        genre.add(e);
      }) ;

    this.director = [];
    map['director'].forEach((e){
      director.add(e);
    }) ;

    this.writers = [];
    map['writers'].forEach((e){
      writers.add(e);
    });

    this.imdbid = map['imdbid'];
  }

}