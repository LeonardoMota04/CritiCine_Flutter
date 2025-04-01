import 'package:flutter/material.dart';
import 'package:movie_api_flutter_project_leonardo/routes/app_routes.dart';
import 'package:movie_api_flutter_project_leonardo/viewmodels/movie_viewmodel.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';

// COMPONENTE REUTILIZÁVEL
// item da lista representando cada filme
class MovieTile extends StatelessWidget {
  final Movie movie; // filme
  final bool showAddButton; // mostrar botão de 'favorito'

  // init
  const MovieTile({Key? key, required this.movie, this.showAddButton = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MovieViewModel>(context, listen: false); // viewmodel do Provider

    return ListTile(
      leading: Image.network(
        "https://image.tmdb.org/t/p/w200${movie.posterPath}",
        fit: BoxFit.cover,
      ),
      title: Text(movie.title),
      subtitle: Text("Nota: ${movie.voteAverage} ⭐"),
      trailing: showAddButton
          ? IconButton(
              onPressed: () {
                String message = viewModel.addToWatchlist(movie);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              },
              icon: Icon(Icons.add),
            )
          : null,
      onTap: () {
        // CHAMANDO ROUTER
        Navigator.pushNamed(
          context,
          AppRoutes.movieDetails,
          arguments: movie.id,
        );
      },
    );
  }
}