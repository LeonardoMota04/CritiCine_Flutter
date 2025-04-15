import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_api_flutter_project_leonardo/core/constants/api_contants.dart';
import 'package:movie_api_flutter_project_leonardo/models/movie.dart';
import 'package:movie_api_flutter_project_leonardo/models/movie_details.dart';

class ApiService {
  // CHAVE DE API
  final String apiKey = dotenv.env['API_KEY'] ?? '';

  // BUSCA FILMES EM EXIBIÇÃO
  Future<List<Movie>> fetchMovies() async {
    final url = Uri.parse(
      "${APIConstants.baseUrl}${APIConstants.nowPlayingEndpoint}?api_key=$apiKey&language=pt-BR",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data["results"] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    } else {
      throw Exception("Erro ao carregar filmes");
    }
  }

  // BUSCA DETALHES DE UM FILME
  Future<MovieDetails> fetchMovieDetails(int movieId) async {
    final url = Uri.parse(
      "${APIConstants.baseUrl}${APIConstants.movieDetailsEndpoint}/$movieId?api_key=$apiKey&language=pt-BR",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return MovieDetails.fromJson(jsonData);
    } else {
      throw Exception("Erro ao carregar detalhes do filme");
    }
  }
}
