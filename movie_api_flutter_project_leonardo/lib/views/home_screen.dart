import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/movie_viewmodel.dart';
import '../viewmodels/theme_viewmodel.dart';
import '../core/enums/request_state.dart';
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: _buildDrawer(),
      body: _buildUI(),
      bottomNavigationBar: _bottomTabs(),
    );
  }

  Widget _buildDrawer() {
    final themeViewModel = Provider.of<ThemeViewModel>(context);
    
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "Leonardo Mota",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: const Text("leonardo@exemplo.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Text(
                "LM",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Início"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favoritos"),
            onTap: () {
              Navigator.pop(context);
              // Ação mockup
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Histórico"),
            onTap: () {
              Navigator.pop(context);
              // Ação mockup
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Configurações"),
            onTap: () {
              Navigator.pop(context);
              // Ação mockup
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Sobre"),
            onTap: () {
              Navigator.pop(context);
              // Ação mockup
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: Icon(
              themeViewModel.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            title: Text(
              themeViewModel.isDarkMode ? "Modo claro" : "Modo escuro",
            ),
            onTap: () {
              themeViewModel.toggleTheme();
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // AppBar 
  PreferredSizeWidget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text(
        "🎬 Em cartaz",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          color: Colors.white,
          icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
          onPressed: () {
            setState(() {
              _isGridView = !_isGridView;
            });
          },
        ),
      ],
    );
  }

  // Body
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

  // Movies Tab 
  Widget _buildMoviesTab(MovieViewModel movieViewModel) {
    switch (movieViewModel.state) {
      case RequestState.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case RequestState.success:
        return MovieList(
          movies: movieViewModel.movies,
          showAddButton: true,
          isGridView: _isGridView,
        );
      case RequestState.error:
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
                movieViewModel.errorMessage,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => movieViewModel.loadMovies(),
                icon: const Icon(Icons.refresh),
                label: const Text("Tentar Novamente"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
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
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.bookmark_border,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              "Nenhum filme na lista para assistir",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }
    return MovieList(
      movies: movieViewModel.watchlist,
      showAddButton: false,
      isGridView: _isGridView,
    );
  }

  // Bottom TabBar
  Widget _bottomTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(
            icon: Icon(Icons.movie),
            text: "Em Cartaz",
          ),
          Tab(
            icon: Icon(Icons.bookmark),
            text: "Para Assistir",
          ),
        ],
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Theme.of(context).primaryColor,
        indicatorWeight: 3,
      ),
    );
  }
}
