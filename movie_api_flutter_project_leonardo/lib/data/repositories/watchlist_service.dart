import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_api_flutter_project_leonardo/domain/models/movie.dart';

class WatchlistService {
  static const String _boxName = 'watchlist';
  late Box<Movie> _watchlistBox;

  // Inicializa o Hive e abre a box
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MovieAdapter());
    _watchlistBox = await Hive.openBox<Movie>(_boxName);
  }

  // Adiciona um filme à watchlist
  Future<void> addMovie(Movie movie) async {
    await _watchlistBox.put(movie.id.toString(), movie);
  }

  // Remove um filme da watchlist
  Future<void> removeMovie(int movieId) async {
    await _watchlistBox.delete(movieId.toString());
  }

  // Verifica se um filme está na watchlist
  bool isMovieInWatchlist(int movieId) {
    return _watchlistBox.containsKey(movieId.toString());
  }

  // Obtém todos os filmes da watchlist
  List<Movie> getAllMovies() {
    return _watchlistBox.values.toList();
  }

  // Limpa a watchlist
  Future<void> clearWatchlist() async {
    await _watchlistBox.clear();
  }
} 