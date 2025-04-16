import 'package:flutter/material.dart';
import 'package:movie_api_flutter_project_leonardo/core/network/api_service.dart';
import 'package:movie_api_flutter_project_leonardo/repository/movie_repository.dart';
import 'package:provider/provider.dart';
import 'viewmodels/movie_viewmodel.dart';
import 'viewmodels/theme_viewmodel.dart';
import 'routes/app_routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // CARREGA O ARQUIVO .ENV
  await dotenv.load();

  // INICIALIZANDO E INJETANDO DEPENDÊNCIAS
  final apiService = ApiService(); // SERVICE DE API
  final movieRepository = MovieRepository(apiService); // REPOSITORY COM A API

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieViewModel(movieRepository)),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
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
    
    return MaterialApp(
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
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
