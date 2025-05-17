import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../models/movie_details.dart';
import '../repository/movie_repository.dart';
import '../core/enums/request_state.dart';
import '../services/watchlist_service.dart';

// MOVIE VIEW MODEL 
// referências ao Repository e aos modelos
class MovieViewModel extends ChangeNotifier {
  // REPOSITORY
  final MovieRepository movieRepository;
  final WatchlistService _watchlistService = WatchlistService();

  // MODELOS
  List<Movie> movies = []; // filme
  MovieDetails? movieDetails; // detalhes do filme
  List<Movie> _watchlist = []; // filmes 'para assistir'
  List<Movie> get watchlist => _watchlist; // getter

  // ESTADO DE CARREGAMENTO
  RequestState state = RequestState.idle;
  RequestState detailsState = RequestState.idle;
  String errorMessage = "";

  // init
  MovieViewModel(this.movieRepository) {
    _initWatchlist();
  }

  // Inicializa a watchlist
  Future<void> _initWatchlist() async {
    await _watchlistService.init();
    _watchlist = _watchlistService.getAllMovies();
    notifyListeners();
  }

  // CARREGA TODOS FILMES
  Future<void> loadMovies() async {
    state = RequestState.loading;
    notifyListeners();

    try {
      movies = await movieRepository.getMovies();
      state = RequestState.success;
    } catch (e) {
      errorMessage = "Erro ao carregar filmes";
      state = RequestState.error;
    }

    notifyListeners();
  }

  // CARREGA DETALHES DE UM FILME
  Future<void> loadMovieDetails(int movieId) async {
    detailsState = RequestState.loading;
    notifyListeners();

    try {
      movieDetails = await movieRepository.getMovieDetails(movieId);
      detailsState = RequestState.success;
    } catch (e) {
      errorMessage = "Erro ao carregar detalhes do filme";
      detailsState = RequestState.error;
    }

    notifyListeners();
  }

  // VERIFICA SE O FILME ESTÁ NA WATCHLIST
  bool isInWatchlist(int movieId) {
    return _watchlistService.isMovieInWatchlist(movieId);
  }

  // ADICIONA OU REMOVE FILME DA WATCHLIST
  Future<String> toggleWatchlist(Movie movie) async {
    if (isInWatchlist(movie.id)) {
      await _watchlistService.removeMovie(movie.id);
      _watchlist = _watchlistService.getAllMovies();
      notifyListeners();
      return "${movie.title} foi removido da lista!";
    } else {
      await _watchlistService.addMovie(movie);
      _watchlist = _watchlistService.getAllMovies();
      notifyListeners();
      return "${movie.title} foi adicionado à lista!";
    }
  }
}
