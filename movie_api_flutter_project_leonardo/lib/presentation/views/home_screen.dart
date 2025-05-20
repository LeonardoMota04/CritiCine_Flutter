import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/movie_viewmodel.dart';
import '../../core/enums/request_state.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/loading_state.dart';
import '../widgets/error_state.dart';
import '../widgets/empty_state.dart';
import '../widgets/movie_list.dart';

// HOME SCREEN
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController; // tab 
  bool _isGridView = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // ADIAR CHAMADA PARA DEPOIS DO PRIMEIRO FRAME (evita thread overloading)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieViewModel>(context, listen: false).loadMovies();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Scaffold(
        drawer: const CustomDrawer(),
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 100,
                floating: true,
                pinned: true,
                snap: true,
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                leading: IconButton(
                  icon: Icon(
                    Icons.menu_rounded,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "🎬 CritiCine",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.titleLarge?.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      _isGridView ? Icons.view_list : Icons.grid_view,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () => setState(() => _isGridView = !_isGridView),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ];
          },
          body: _buildUI(),
        ),
        bottomNavigationBar: CustomTabBar(controller: _tabController),
      ),
    );
  }

  Widget _buildUI() {
    final movieViewModel = Provider.of<MovieViewModel>(context);

    return TabBarView(
      controller: _tabController,
      children: [
        _buildMoviesTab(movieViewModel),
        _buildWatchlistTab(movieViewModel),
      ],
    );
  }

  Widget _buildMoviesTab(MovieViewModel movieViewModel) {
    switch (movieViewModel.state) {
      case RequestState.loading:
        return const LoadingState();
      case RequestState.success:
        return MovieList(
          movies: movieViewModel.movies,
          showAddButton: true,
          isGridView: _isGridView,
        );
      case RequestState.error:
        return ErrorState(
          message: movieViewModel.errorMessage,
          onRetry: () => movieViewModel.loadMovies(),
        );
      default:
        return Center(
          child: ElevatedButton.icon(
            onPressed: () => movieViewModel.loadMovies(),
            icon: const Icon(Icons.movie),
            label: const Text("Buscar filmes em cartaz"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        );
    }
  }

  Widget _buildWatchlistTab(MovieViewModel movieViewModel) {
    if (movieViewModel.watchlist.isEmpty) {
      return const EmptyState(
        icon: Icons.bookmark_border,
        message: "Nenhum filme na lista para assistir",
      );
    }
    return MovieList(
      movies: movieViewModel.watchlist,
      showAddButton: false,
      isGridView: _isGridView,
    );
  }
}
