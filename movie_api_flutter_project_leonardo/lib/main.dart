import 'package:flutter/material.dart';
import 'package:movie_api_flutter_project_leonardo/data/repositories/movie_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_api_flutter_project_leonardo/data/repositories/preferences_manager.dart';

import 'presentation/viewmodels/movie_viewmodel.dart';
import 'presentation/viewmodels/theme_viewmodel.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/viewmodels/auth_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // CARREGA O .env
  await dotenv.load();

  // INICIALIZA O FIREBASE
  await Firebase.initializeApp();

  // INICIALIZA O PreferencesManager
  await PreferencesManager.init();

  // INICIALIZANDO E INJETANDO DEPENDÊNCIAS
  final apiClient = MovieRepositoryImpl();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieViewModel(apiClient)),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeViewModel, AuthViewModel>(
      builder: (context, themeViewModel, authProvider, child) {
        const Color customPurple = Color(0xFF6A1B9A);

        return MaterialApp(
          navigatorKey: navigatorKey,
          title: 'CritiCine',
          debugShowCheckedModeBanner: false,
          themeMode: themeViewModel.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            primaryColor: customPurple,
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: customPurple,
              primary: customPurple,
              secondary: Colors.deepPurpleAccent,
              brightness: Brightness.light,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: customPurple,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            tabBarTheme: const TabBarTheme(
              labelColor: customPurple,
              unselectedLabelColor: Colors.grey,
              indicatorColor: customPurple,
            ),
          ),
          darkTheme: ThemeData(
            primaryColor: customPurple,
            scaffoldBackgroundColor: Colors.grey[900],
            colorScheme: ColorScheme.fromSeed(
              seedColor: customPurple,
              primary: customPurple,
              secondary: Colors.deepPurpleAccent,
              brightness: Brightness.dark,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey[850],
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            tabBarTheme: const TabBarTheme(
              labelColor: customPurple,
              unselectedLabelColor: Colors.grey,
              indicatorColor: customPurple,
            ),
          ),
          initialRoute: authProvider.isAuthenticated
              ? AppRoutes.home
              : AppRoutes.login,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      },
    );
  }
}
