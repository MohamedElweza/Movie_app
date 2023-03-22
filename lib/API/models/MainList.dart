import 'MoviesList.dart';

class MainList{

late List<Movie> mainData;

  MainList({
 required this.mainData,
});

  MainList.fromList(List<dynamic> map){

    this.mainData = [];
      (map).forEach((element) {
      this.mainData.add(Movie.fromMap(element));
    });

  }





}