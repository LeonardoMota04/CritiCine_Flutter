import 'package:flutter/material.dart';

class AppTheme {
  // Cores principais - Tema Claro
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFF03DAC5);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFB00020);

  // Cores principais - Tema Escuro
  static const Color darkPrimaryColor = Color(0xFF8B85FF);
  static const Color darkSecondaryColor = Color(0xFF03DAC5);
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkSurfaceColor = Color(0xFF1E1E1E);
  static const Color darkErrorColor = Color(0xFFCF6679);

  // Cores de texto - Tema Claro
  static const Color textPrimaryColor = Color(0xFF1A1A1A);
  static const Color textSecondaryColor = Color(0xFF757575);
  static const Color textHintColor = Color(0xFFBDBDBD);

  // Cores de texto - Tema Escuro
  static const Color darkTextPrimaryColor = Color(0xFFE1E1E1);
  static const Color darkTextSecondaryColor = Color(0xFFB0B0B0);
  static const Color darkTextHintColor = Color(0xFF757575);

  // Sombras
  static List<BoxShadow> defaultShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> darkShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  // Bordas arredondadas
  static const double borderRadius = 16.0;
  static const double borderRadiusSmall = 8.0;

  // Espaçamentos
  static const double padding = 16.0;
  static const double paddingSmall = 8.0;
  static const double paddingLarge = 24.0;

  // Tamanhos de fonte
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 14.0;
  static const double fontSizeLarge = 16.0;
  static const double fontSizeXLarge = 20.0;
  static const double fontSizeXXLarge = 24.0;

  // Estilos de texto - Tema Claro
  static const TextStyle headlineStyle = TextStyle(
    fontSize: fontSizeXXLarge,
    fontWeight: FontWeight.bold,
    color: textPrimaryColor,
  );

  static const TextStyle titleStyle = TextStyle(
    fontSize: fontSizeXLarge,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: fontSizeLarge,
    fontWeight: FontWeight.w500,
    color: textSecondaryColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: fontSizeMedium,
    color: textPrimaryColor,
  );

  static const TextStyle captionStyle = TextStyle(
    fontSize: fontSizeSmall,
    color: textSecondaryColor,
  );

  // Estilos de texto - Tema Escuro
  static const TextStyle darkHeadlineStyle = TextStyle(
    fontSize: fontSizeXXLarge,
    fontWeight: FontWeight.bold,
    color: darkTextPrimaryColor,
  );

  static const TextStyle darkTitleStyle = TextStyle(
    fontSize: fontSizeXLarge,
    fontWeight: FontWeight.w600,
    color: darkTextPrimaryColor,
  );

  static const TextStyle darkSubtitleStyle = TextStyle(
    fontSize: fontSizeLarge,
    fontWeight: FontWeight.w500,
    color: darkTextSecondaryColor,
  );

  static const TextStyle darkBodyStyle = TextStyle(
    fontSize: fontSizeMedium,
    color: darkTextPrimaryColor,
  );

  static const TextStyle darkCaptionStyle = TextStyle(
    fontSize: fontSizeSmall,
    color: darkTextSecondaryColor,
  );

  // Estilo do botão - Tema Claro
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(
      horizontal: paddingLarge,
      vertical: padding,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    elevation: 0,
  );

  // Estilo do botão - Tema Escuro
  static ButtonStyle darkPrimaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: darkPrimaryColor,
    foregroundColor: darkTextPrimaryColor,
    padding: const EdgeInsets.symmetric(
      horizontal: paddingLarge,
      vertical: padding,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    elevation: 0,
  );

  // Estilo do card - Tema Claro
  static BoxDecoration cardDecoration = BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: defaultShadow,
  );

  // Estilo do card - Tema Escuro
  static BoxDecoration darkCardDecoration = BoxDecoration(
    color: darkSurfaceColor,
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: darkShadow,
  );

  // Método para obter as cores baseado no tema
  static ColorScheme getColorScheme(bool isDarkMode) {
    return isDarkMode
        ? const ColorScheme.dark(
            primary: darkPrimaryColor,
            secondary: darkSecondaryColor,
            surface: darkSurfaceColor,
            error: darkErrorColor,
          )
        : const ColorScheme.light(
            primary: primaryColor,
            secondary: secondaryColor,
            surface: surfaceColor,
            error: errorColor,
          );
  }

  // Método para obter os estilos de texto baseado no tema
  static TextStyle getHeadlineStyle(bool isDarkMode) =>
      isDarkMode ? darkHeadlineStyle : headlineStyle;

  static TextStyle getTitleStyle(bool isDarkMode) =>
      isDarkMode ? darkTitleStyle : titleStyle;

  static TextStyle getSubtitleStyle(bool isDarkMode) =>
      isDarkMode ? darkSubtitleStyle : subtitleStyle;

  static TextStyle getBodyStyle(bool isDarkMode) =>
      isDarkMode ? darkBodyStyle : bodyStyle;

  static TextStyle getCaptionStyle(bool isDarkMode) =>
      isDarkMode ? darkCaptionStyle : captionStyle;

  // Método para obter o estilo do botão baseado no tema
  static ButtonStyle getPrimaryButtonStyle(bool isDarkMode) =>
      isDarkMode ? darkPrimaryButtonStyle : primaryButtonStyle;

  // Método para obter a decoração do card baseado no tema
  static BoxDecoration getCardDecoration(bool isDarkMode) =>
      isDarkMode ? darkCardDecoration : cardDecoration;
} 