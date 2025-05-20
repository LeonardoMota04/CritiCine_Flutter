import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_theme.dart';

class ThemeViewModel extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeViewModel() {
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppTheme.getColorScheme(_isDarkMode),
      scaffoldBackgroundColor: _isDarkMode 
        ? AppTheme.darkBackgroundColor 
        : AppTheme.backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: _isDarkMode 
          ? AppTheme.darkPrimaryColor 
          : AppTheme.primaryColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: AppTheme.getTitleStyle(_isDarkMode).copyWith(
          color: Colors.white,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        ),
        color: _isDarkMode 
          ? AppTheme.darkSurfaceColor 
          : AppTheme.surfaceColor,
      ),
      textTheme: TextTheme(
        displayLarge: AppTheme.getHeadlineStyle(_isDarkMode),
        displayMedium: AppTheme.getTitleStyle(_isDarkMode),
        displaySmall: AppTheme.getSubtitleStyle(_isDarkMode),
        bodyLarge: AppTheme.getBodyStyle(_isDarkMode),
        bodyMedium: AppTheme.getBodyStyle(_isDarkMode),
        bodySmall: AppTheme.getCaptionStyle(_isDarkMode),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: AppTheme.getPrimaryButtonStyle(_isDarkMode),
      ),
      dividerTheme: DividerThemeData(
        color: _isDarkMode 
          ? AppTheme.darkTextSecondaryColor.withOpacity(0.2)
          : AppTheme.textSecondaryColor.withOpacity(0.2),
      ),
    );
  }
} 