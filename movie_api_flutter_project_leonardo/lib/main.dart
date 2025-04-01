import 'package:flutter/material.dart';
import 'package:movie_api_flutter_project_leonardo/core/network/api_service.dart';
import 'package:movie_api_flutter_project_leonardo/repository/movie_repository.dart';
import 'package:provider/provider.dart';
import 'viewmodels/movie_viewmodel.dart';
import 'routes/app_routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // CARREGA O ARQUIVO .ENV
  await dotenv.load();

  // INICIALIZANDO E INJETANDO DEPENDÊNCIAS
  final apiService = ApiService(); // SERVICE DE API
  final movieRepository = MovieRepository(apiService); // REPOSITORY COM A API

  runApp(
    ChangeNotifierProvider( // PROVIDER
      create: (_) => MovieViewModel(movieRepository),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filmes em cartaz',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
