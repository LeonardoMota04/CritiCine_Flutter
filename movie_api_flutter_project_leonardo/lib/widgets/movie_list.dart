import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'movie_tile.dart';

// COMPONENTE REUTILIZÁVEL
// LISTA DE FILMES
class MovieList extends StatelessWidget {
  final List<Movie> movies; // array de filmes
  final bool showAddButton; // mostrar botão de adicionar à 'favoritos'
  final bool isGridView;

  const MovieList({
    super.key,
    required this.movies,
    required this.showAddButton,
    this.isGridView = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isGridView) {
      return GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return MovieTile(
            movie: movies[index],
            showAddButton: showAddButton,
            isGridView: true,
          );
        },
      );
    }

    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieTile(
          movie: movies[index],
          showAddButton: showAddButton,
          isGridView: false,
        );
      },
    );
  }
}