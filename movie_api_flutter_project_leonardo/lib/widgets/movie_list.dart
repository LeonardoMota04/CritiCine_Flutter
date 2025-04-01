import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'movie_tile.dart'; 

// COMPONENTE REUTILIZÁVEL
// LISTA DE FILMES
class MovieList extends StatelessWidget {
  final List<Movie> movies; // array de filmes
  final bool showAddButton; // mostrar botão de adicionar à 'favoritos'

  // init
  const MovieList({
    Key? key,
    required this.movies,
    required this.showAddButton, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieTile(
          movie: movies[index],
          showAddButton: showAddButton, 
        );
      },
    );
  }
}