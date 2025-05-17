import 'package:flutter/material.dart';
import 'package:movie_api_flutter_project_leonardo/widgets/comments_section.dart';
import 'package:provider/provider.dart';
import 'package:movie_api_flutter_project_leonardo/core/constants/api_contants.dart';
import 'package:movie_api_flutter_project_leonardo/core/enums/request_state.dart';
import 'package:movie_api_flutter_project_leonardo/viewmodels/movie_viewmodel.dart';
import 'package:movie_api_flutter_project_leonardo/models/movie.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Carrega os detalhes após a construção da tela
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<MovieViewModel>();
      viewModel.loadMovieDetails(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: _buildBody(viewModel),
        );
      },
    );
  }

  Widget _buildBody(MovieViewModel viewModel) {
    final state = viewModel.detailsState;

    if (state == RequestState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state == RequestState.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              viewModel.errorMessage,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final movie = viewModel.movieDetails;
    if (movie == null) {
      return const Center(
        child: Text("Nenhum detalhe encontrado para este filme."),
      );
    }

    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(movie, viewModel),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMovieInfo(movie),
                const SizedBox(height: 24),
                _buildOverview(movie),
                const SizedBox(height: 24),
                CommentsSection(movieId: movie.id, movieTitle: movie.title),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSliverAppBar(dynamic movie, MovieViewModel viewModel) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(
            viewModel.isInWatchlist(movie.id)
                ? Icons.bookmark
                : Icons.bookmark_border,
            color: Colors.white,
          ),
          onPressed: () async {
            // objeto Movie a partir dos detalhes
            final movieToAdd = Movie(
              id: movie.id,
              title: movie.title,
              overview: movie.overview,
              posterPath: movie.posterPath,
              voteAverage: movie.voteAverage,
            );
            
            String message = await viewModel.toggleWatchlist(movieToAdd);
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
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              '${APIConstants.posterSizeW500}${movie.posterPath}',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 100),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieInfo(dynamic movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    movie.voteAverage.toStringAsFixed(1),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16),
                  const SizedBox(width: 4),
                  Text(movie.releaseDate),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOverview(dynamic movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Sinopse",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          movie.overview,
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
