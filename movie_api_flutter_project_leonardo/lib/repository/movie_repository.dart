import 'package:movie_api_flutter_project_leonardo/core/network/api_client.dart';
import 'package:movie_api_flutter_project_leonardo/models/movie_details.dart';
import '../core/network/api_service.dart';
import '../models/movie.dart';

// REPOSITORY DE FILME PARA ENTREGA À VIEW MODEL 
class MovieRepository {
  final ApiClient apiClient;

  MovieRepository(this.apiClient);

  // FAZ O GET DE TODOS OS FILMES
  Future<List<Movie>> getMovies() => apiClient.fetchMovies();

  // FAZ O GET DOS DETALHES DE UM FILME (requer ID)
  Future<MovieDetails> getMovieDetails(int movieId) => apiClient.fetchMovieDetails(movieId);
}
