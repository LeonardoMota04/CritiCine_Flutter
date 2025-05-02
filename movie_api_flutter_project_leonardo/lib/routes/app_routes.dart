import 'package:flutter/material.dart';
import '../views/home_screen.dart';
import '../views/movie_details_screen.dart';
import '../views/login_screen.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';

// ROUTER do App
class AppRoutes {
  static const String home = '/'; // página principal
  static const String movieDetails = '/movieDetails'; // detalhes do filme clicado
  static const String login = '/login'; // tela de login

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final authProvider = Provider.of<AuthProvider>(navigatorKey.currentContext!, listen: false);
    
    // Se não estiver autenticado e não estiver na tela de login, redireciona para login
    if (!authProvider.isAuthenticated && settings.name != login) {
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    }

    switch (settings.name) {
      // HOME
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
  
      // MOVIE DETAILS
      case movieDetails:
        final int movieId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MovieDetailsScreen(movieId: movieId),
        );

      // LOGIN
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

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

// Chave global para acessar o contexto de navegação
final navigatorKey = GlobalKey<NavigatorState>();
