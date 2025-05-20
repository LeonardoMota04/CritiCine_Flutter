import 'package:movie_api_flutter_project_leonardo/domain/models/movie.dart';
import 'package:movie_api_flutter_project_leonardo/domain/models/movie_details.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMovies();
  Future<MovieDetails> fetchMovieDetails(int movieId);
}
