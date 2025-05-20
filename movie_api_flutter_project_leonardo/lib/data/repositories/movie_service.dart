import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_api_flutter_project_leonardo/core/constants/api_contants.dart';
import 'package:movie_api_flutter_project_leonardo/core/constants/api_error.dart';
import 'package:movie_api_flutter_project_leonardo/domain/repository/movie_repository.dart';
import 'package:movie_api_flutter_project_leonardo/domain/models/movie.dart';
import 'package:movie_api_flutter_project_leonardo/domain/models/movie_details.dart';


/// TmbdApiClient
class MovieRepositoryImpl implements MovieRepository {
  final http.Client client;
  final String apiKey = dotenv.env['API_KEY'] ?? '';

  MovieRepositoryImpl({http.Client? client}) : client = client ?? http.Client();

  @override
  Future<List<Movie>> fetchMovies() async {
    final url = Uri.parse(
      "${APIConstants.baseUrl}${APIConstants.nowPlayingEndpoint}?api_key=$apiKey&language=pt-BR",
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data["results"] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    } else {
      throw _handleError(response.statusCode);
    }
  }


  // GET 
  // BUSCA DETALHES DE UM FILME POR ID 
  @override
  Future<MovieDetails> fetchMovieDetails(int movieId) async {
    // url
    final url = Uri.parse(
      "${APIConstants.baseUrl}${APIConstants.movieDetailsEndpoint}/$movieId?api_key=$apiKey&language=pt-BR",
    );

    // response
    final response = await client.get(url);

    if (response.statusCode == 200) {
      // sucesso
      final data = jsonDecode(response.body);
      return MovieDetails.fromJson(data);
    } else {
      // lida com erro de requisição
      throw _handleError(response.statusCode);
    }
  }

  // LIDA COM ERROS DE REQUISIÇÃO
  ApiError _handleError(int statusCode) {
    switch (statusCode) {
      case 401:
        return ApiError(type: ApiErrorType.unauthorized, message: "Chave de API inválida.");
      case 404:
        return ApiError(type: ApiErrorType.notFound, message: "Recurso não encontrado.");
      case 500:
        return ApiError(type: ApiErrorType.server, message: "Erro no servidor.");
      default:
        return ApiError(type: ApiErrorType.unknown, message: "Erro desconhecido.");
    }
  }
}