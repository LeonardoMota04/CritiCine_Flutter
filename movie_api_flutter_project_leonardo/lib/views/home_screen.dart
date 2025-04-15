import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/movie_viewmodel.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    //Provider.of<MovieViewModel>(context, listen: false).loadMovies();
    // comentado para mostrar estado de carregamento forçado
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
      body: _buildUI(),
      bottomNavigationBar: _bottomTabs(),
    );
  }

  // AppBar 
  PreferredSizeWidget _appBar() {
    return AppBar(title: Text("🎬 Em cartaz"));
  }

  // Body
  Widget _buildUI() {
    final movieViewModel = Provider.of<MovieViewModel>(context);

    return TabBarView(
      controller: _tabController,
      children: [
        // "Em Cartaz" ---------------------------------
        Center(
          child: Builder(
            builder: (contex) {
              switch (movieViewModel.state) {
                case RequestState.loading:
                // loading view
                  return CircularProgressIndicator();
                case RequestState.success:
                // movie list view
                  return MovieList(movies: movieViewModel.movies, showAddButton: true);
                case RequestState.error:
                // error view
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(movieViewModel.errorMessage, style: TextStyle(color: Colors.red)),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => movieViewModel.loadMovies(),
                        child: Text("Tentar Novamente"),
                      ),
                    ],
                  );
                default:
                  return ElevatedButton(
                    onPressed: () => movieViewModel.loadMovies(),
                    child: Text("Buscar filmes em cartaz"),
                  );
              }
            },
          ),
        ),

        // "Para Assistir" ---------------------------------
        movieViewModel.watchlist.isEmpty
            ? Center(child: Text("Nenhum filme na lista para assistir"))
            : MovieList(movies: movieViewModel.watchlist, showAddButton: false),
      ],
    );
  }

  // Bottom TabBar
  Widget _bottomTabs() {
    return TabBar(
      controller: _tabController,
      tabs: [
        Tab(text: "Em Cartaz", icon: Icon(Icons.movie)),
        Tab(text: "Para Assistir", icon: Icon(Icons.bookmark)),
      ],
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.transparent,
    );
  }
}
