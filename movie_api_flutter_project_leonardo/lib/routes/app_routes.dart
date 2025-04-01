import 'package:flutter/material.dart';
import '../views/home_screen.dart';
import '../views/movie_details_screen.dart';

// ROUTER do App
class AppRoutes {
  static const String home = '/'; // página principal
  static const String movieDetails = '/movieDetails'; // detalhes do filme clicado

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // HOME
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
  
      // MOVIE DETAILS
      case movieDetails:
        final int movieId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MovieDetailsScreen(movieId: movieId),
        );

      // DEFAULT
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("Página não encontrada")),
          ),
        );
    }
  }
}
