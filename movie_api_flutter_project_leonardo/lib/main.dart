import 'package:flutter/material.dart';
import 'package:movie_api_flutter_project_leonardo/core/network/api_service.dart';
import 'package:movie_api_flutter_project_leonardo/repository/movie_repository.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'viewmodels/movie_viewmodel.dart';
import 'viewmodels/theme_viewmodel.dart';
import 'routes/app_routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'providers/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // CARREGA O ARQUIVO .ENV
  await dotenv.load();

  // INICIALIZA O FIREBASE
  await Firebase.initializeApp();

  // INICIALIZANDO E INJETANDO DEPENDÊNCIAS
  final tmbdClient = TmdbApiClient(); // SERVICE DE API
  final movieRepository = MovieRepository(tmbdClient); // REPOSITORY COM A API

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieViewModel(movieRepository)),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeViewModel = Provider.of<ThemeViewModel>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Filmes em cartaz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[850],
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: themeViewModel.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: authProvider.isAuthenticated ? AppRoutes.home : AppRoutes.login,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
