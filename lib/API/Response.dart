import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/MainList.dart';

Future<MainList> GetAllMovies() async {
  http.Response request = await http.get(
      Uri.https('imdb-top-100-movies.p.rapidapi.com', '/'),
      headers: {
        'X-RapidAPI-Key': 'd605f03099msh03cc56450f1bd76p1942e7jsn4a513acd25db',
        'X-RapidAPI-Host': 'imdb-top-100-movies.p.rapidapi.com'
      });
  if (request.statusCode <= 299 && request.statusCode >= 200) {
    final List< dynamic> jsonBody = json.decode(request.body);
    MainList MovieResponse = MainList.fromList(jsonBody);
    return MovieResponse;
  } else {
    throw ('Request Fail');
  }
}
