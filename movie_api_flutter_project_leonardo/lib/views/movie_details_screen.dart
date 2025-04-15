import 'package:flutter/material.dart';
import 'package:movie_api_flutter_project_leonardo/core/enums/request_state.dart';
import 'package:movie_api_flutter_project_leonardo/viewmodels/movie_viewmodel.dart';
import 'package:provider/provider.dart';

// MOVIE DETAILS SCREEN
class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  MovieDetailsScreenState createState() => MovieDetailsScreenState();
}
 
class MovieDetailsScreenState extends State<MovieDetailsScreen> {

  @override
  void initState() {
    super.initState();
    
    // addPostFrameCallback para garantir que a função seja chamada após a construção do widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<MovieViewModel>(context, listen: false);
      viewModel.loadMovieDetails(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes do filme')),
      body: Consumer<MovieViewModel>(
        builder: (context, viewModel, child) {
          // VERIFICAÇÕES (lógica pode ir para um formatter por exemplo)
          if (viewModel.detailsState == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.detailsState == RequestState.error) {
            return Center(child: Text(viewModel.errorMessage));
          }

          if (viewModel.movieDetails == null) {
            return const Center(child: Text("Nenhum detalhe encontrado para este filme."));
          }

          final movie = viewModel.movieDetails!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    height: 300,
                  ),
                ),
                const SizedBox(height: 16),
                Text(movie.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Nota: ${movie.voteAverage.toStringAsFixed(1)} ⭐'),
                const SizedBox(height: 8),
                Text('Lançamento: ${movie.releaseDate}'),
                const SizedBox(height: 16),
                Text(movie.overview),
              ],
            ),
          );
        },
      ),
    );
  }
}
