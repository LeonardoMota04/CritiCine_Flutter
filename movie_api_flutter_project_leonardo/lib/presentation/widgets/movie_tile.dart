import 'package:flutter/material.dart';
import 'package:movie_api_flutter_project_leonardo/core/constants/api_contants.dart';
import 'package:movie_api_flutter_project_leonardo/presentation/routes/app_routes.dart';
import 'package:movie_api_flutter_project_leonardo/presentation/viewmodels/movie_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../domain/models/movie.dart';

// COMPONENTE REUTILIZÁVEL
// item da lista representando cada filme
class MovieTile extends StatelessWidget {
  final Movie movie; // filme
  final bool showAddButton; // mostrar botão de 'favorito'
  final bool isGridView;

  // init
  const MovieTile({
    super.key,
    required this.movie,
    this.showAddButton = false,
    this.isGridView = false,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MovieViewModel>(context); // viewmodel do Provider

    if (isGridView) {
      return _buildGridTile(context, viewModel);
    }

    return _buildListTile(context, viewModel);
  }

  Widget _buildGridTile(BuildContext context, MovieViewModel viewModel) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => _navigateToDetails(context),
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.network(
                  "${APIConstants.posterSizeW200}${movie.posterPath}",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "⭐ ${movie.voteAverage.toStringAsFixed(1)}",
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (showAddButton)
                        IconButton(
                          onPressed: () => _toggleWatchlist(context, viewModel),
                          icon: Icon(
                            viewModel.isInWatchlist(movie.id)
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                          ),
                          iconSize: 20,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, MovieViewModel viewModel) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            "${APIConstants.posterSizeW200}${movie.posterPath}",
            width: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 50),
          ),
        ),
        title: Text(
          movie.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "⭐ ${movie.voteAverage.toStringAsFixed(1)}",
          style: const TextStyle(color: Colors.amber),
        ),
        trailing: showAddButton
            ? IconButton(
                onPressed: () => _toggleWatchlist(context, viewModel),
                icon: Icon(
                  viewModel.isInWatchlist(movie.id)
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                ),
              )
            : null,
        onTap: () => _navigateToDetails(context),
      ),
    );
  }

  // FUNÇÕES 
  void _navigateToDetails(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.movieDetails,
      arguments: movie.id,
    );
  }

  void _toggleWatchlist(BuildContext context, MovieViewModel viewModel) async {
    String message = await viewModel.toggleWatchlist(movie);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }
}