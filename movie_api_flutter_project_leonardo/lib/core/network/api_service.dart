import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_api_flutter_project_leonardo/models/movie_details.dart';
import '../../models/movie.dart';

// VARIÁVEIS DE CONFIGURAÇÃO DA API
final String apiKey = dotenv.env['API_KEY'] ?? ''; // CHAVE DA API
const String baseUrl = "https://api.themoviedb.org/3";

class ApiService {
  // FUNÇÃO PARA BUSCAR FILMES EM EXIBIÇÃO
  Future<List<Movie>> fetchMovies() async {
    // CONSTRÓI A URL PARA OBTER A LISTA DE FILMES
    final url = Uri.parse("$baseUrl/movie/now_playing?api_key=$apiKey&language=pt-BR");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data["results"] as List).map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception("ERRO AO CARREGAR FILMES");
    }
  }

  // FUNÇÃO PARA BUSCAR DETALHES DE UM FILME
  Future<MovieDetails> fetchMovieDetails(int movieId) async {
    // CONSTRÓI A URL PARA OBTER OS DETALHES DO FILME
    final url = Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey&language=pt-BR');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return MovieDetails.fromJson(json);
    } else {
      throw Exception('ERRO AO CARREGAR DETALHES DO FILME');
    }
  }
}
