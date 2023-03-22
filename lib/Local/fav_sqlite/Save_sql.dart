import 'package:cut/Local/fav_sqlite/dbHelper_Save.dart';

class Save {

  late String id;
  late String image;
  late String title;
  late String genre;
  late String trailer;
  late String rating;
  late int year;


  Save({
    required this.id,
    required this.title,
    required this.image,
    required this.genre,
    required this.trailer,
    required this.rating,
    required this.year,
  });

  Save.fromMap(Map<String, dynamic> map) {
    if (map[columnId] != null) id = map[columnId];
    image = map[columnImage];
    title = map[columnTitle];
    trailer = map[columnTrailer];
    rating = map[columnRate];
    genre = map[columnGenre];
    year = map[columnYear];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (id != null) map[columnId] = id;
    map[columnImage]  = image;
    map[columnTitle] = title;
    map[columnTrailer] = trailer;
    map[columnRate] = rating;
    map[columnGenre] = genre;
    map[columnYear] = year;
    return map;
  }
}
