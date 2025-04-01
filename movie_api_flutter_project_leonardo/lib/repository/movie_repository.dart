import 'package:movie_api_flutter_project_leonardo/models/movie_details.dart';
import '../core/network/api_service.dart';
import '../models/movie.dart';

// REPOSITORY DE FILME PARA ENTREGA À VIEW MODEL 
class MovieRepository {
  final ApiService apiService;

  MovieRepository(this.apiService);

  // todos os filmes
  Future<List<Movie>> getMovies() {
    return apiService.fetchMovies();
  }

  // detalhes de um filme 
  // requer id
  Future<MovieDetails> getMovieDetails(int movieId) {
    return apiService.fetchMovieDetails(movieId);
  }
}
