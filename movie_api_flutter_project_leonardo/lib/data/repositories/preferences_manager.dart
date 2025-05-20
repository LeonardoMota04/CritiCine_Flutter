import 'package:shared_preferences/shared_preferences.dart';

// SHARED PREFERENCES PARA SALVAR CONFIGURAÇÕES DO USUÁRIO
class PreferencesManager {
  static const String _themeKey = 'theme_mode';
  static late SharedPreferences _prefs;

  // INICIALIZA O SHARED PREFERENCES
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // SALVA O TEMA ESCOLHIDO PELO USUÁRIO
  static Future<void> setThemeMode(bool isDarkMode) async {
    await _prefs.setBool(_themeKey, isDarkMode);
  }

  // OBTÉM O TEMA SALVO
  static bool getThemeMode() {
    return _prefs.getBool(_themeKey) ?? false; // false = tema claro (padrão)
  }
} 