import 'package:flutter/material.dart';
import 'package:movie_api_flutter_project_leonardo/services/preferences_manager.dart';

class ThemeViewModel extends ChangeNotifier {
  bool _isDarkMode = false;

  // INIT 
  ThemeViewModel() {
    _loadTheme();
  }

  bool get isDarkMode => _isDarkMode;

  // CARREGA O TEMA SALVO 
  Future<void> _loadTheme() async {
    _isDarkMode = PreferencesManager.getThemeMode();
    notifyListeners();
  }

  // TOGGLE DO TEMA
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await PreferencesManager.setThemeMode(_isDarkMode);
    notifyListeners();
  }
} 