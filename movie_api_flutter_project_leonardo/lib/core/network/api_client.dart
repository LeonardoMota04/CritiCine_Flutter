import 'package:movie_api_flutter_project_leonardo/models/movie.dart';
import 'package:movie_api_flutter_project_leonardo/models/movie_details.dart';

abstract class ApiClient {
  Future<List<Movie>> fetchMovies();
  Future<MovieDetails> fetchMovieDetails(int movieId);
}
