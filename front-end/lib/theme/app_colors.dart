import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  // ### BACKGROUND COLORS LAYERS ###
  
  /// CAMADA PROFUNDA
  static const Color background = Color(0xFF000D15);
  
  /// CAMADA INTERMEDIÁRIA
  static const Color surface = Color(0xFF03DAC6);

  /// CAMADA SUPERIOR
  static const Color surfaceElevated = Color(0xFFF5F5F5);

  // ### DESTAQUES ###
  static const Color primary = Color(0xFF000000);
  static const Color primaryGradientStart = Color(0xFFFFC107);
  static const Color primaryGradientEnd = Color(0xFFFF8F00);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryGradientStart, primaryGradientEnd],
  );


  // ### TEXTO E ÍCONES ###
  static const Color textPrimary = Colors.white;
  static const Color textSecond = Colors.white70;
  static const Color textMuted = Colors.white60;
  static const Color textHint = Colors.white30;

  // ### BORDAS / DIVISORES ###
  static Color borderSubtle = Colors.white.withValues(alpha: 0.10);
  static Color borderDefault = Colors.white.withValues(alpha: 0.15);
  static Color borderStrong = Colors.white.withValues(alpha: 0.22);
  static const Color divider = Colors.white12;

  // ### STATUS PROJETO ###
  static const Color statusConcluido = Color(0xFF2ECC71);
  static const Color statusPendente = Color(0xFFF39C12);
  static const Color statusEmAndamento = Color(0xFF3498DB);

  // ### FEEDBACK ###
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
  static const Color windowCloseHover = Color(0xFFE81123);
}