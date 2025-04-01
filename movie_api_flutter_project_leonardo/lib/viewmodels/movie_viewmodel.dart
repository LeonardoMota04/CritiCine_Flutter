import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../models/movie_details.dart';
import '../repository/movie_repository.dart';
import '../core/enums/request_state.dart';

// MOVIE VIEW MODEL 
// referências ao Repository e aos modelos
class MovieViewModel extends ChangeNotifier {
  // REPOSITORY
  final MovieRepository movieRepository;

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
  MovieViewModel(this.movieRepository);

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

  // ADICIONA FILME À LISTA DE FILMES PARA ASSISTIR
  String addToWatchlist(Movie movie) {
    if (_watchlist.any((m) => m.id == movie.id)) {
      return "${movie.title} já foi adicionado à lista!";
    } else {
      _watchlist.add(movie);
      notifyListeners();
      return "${movie.title} foi adicionado à lista!";
    }
  }
}
