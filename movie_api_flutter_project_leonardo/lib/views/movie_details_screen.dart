import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_api_flutter_project_leonardo/core/constants/api_contants.dart';
import 'package:movie_api_flutter_project_leonardo/core/enums/request_state.dart';
import 'package:movie_api_flutter_project_leonardo/viewmodels/movie_viewmodel.dart';

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
        final state = viewModel.detailsState;
        final movie = viewModel.movieDetails;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              style: TextStyle(fontSize: 16),
              state == RequestState.success && movie != null
                  ? 'Detalhes de "${movie.title}"'
                  : 'Detalhes do Filme',
            ),
          ),
          body: _buildBody(viewModel),
        );
      },
    );
  }

  // BODY
  Widget _buildBody(MovieViewModel viewModel) {
    final state = viewModel.detailsState;

    if (state == RequestState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state == RequestState.error) {
      return Center(child: Text(viewModel.errorMessage));
    }

    final movie = viewModel.movieDetails;
    if (movie == null) {
      return const Center(
        child: Text("Nenhum detalhe encontrado para este filme."),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              '${APIConstants.posterSizeW500}${movie.posterPath}',
              height: 300,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            movie.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Nota: ${movie.voteAverage.toStringAsFixed(1)} ⭐'),
          const SizedBox(height: 8),
          Text('Lançamento: ${movie.releaseDate}'),
          const SizedBox(height: 16),
          Text(movie.overview),
        ],
      ),
    );
  }
}
