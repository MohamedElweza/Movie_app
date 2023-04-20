import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/MainList.dart';

Future<MainList> GetAllMovies() async {
  http.Response request = await http.get(
      Uri.https('imdb-top-100-movies.p.rapidapi.com', '/'),
      headers: {
        'X-RapidAPI-Key': 'ee5e79af25mshf0d010de53a68dbp1d034ejsn6bbe9769abb2',
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
