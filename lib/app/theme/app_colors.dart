import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF8B1E3F); // Royal Maroon
  static const Color primaryDark = Color(0xFF5E0B25);
  static const Color primaryLight = Color(0xFFC73E67);

  static const Color secondary = Color(0xFFD4AF37); // Royal Gold
  static const Color secondaryDark = Color(0xFFAA820A);
  static const Color secondaryLight = Color(0xFFF3E5AB);

  static const Color accentRose = Color(0xFFE56B6F);
  static const Color accentTeal = Color(0xFF2A9D8F);
  static const Color accentNavy = Color(0xFF1D3557);

  // Neutral Colors (Light)
  static const Color background = Color(0xFFF9F9FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F3F6);
  static const Color textPrimary = Color(0xFF1E1E24);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textMuted = Color(0xFFADB5BD);
  static const Color border = Color(0xFFE2E8F0);

  // Neutral Colors (Dark)
  static const Color darkBackground = Color(0xFF121216);
  static const Color darkSurface = Color(0xFF1E1E26);
  static const Color darkSurfaceVariant = Color(0xFF2B2B36);
  static const Color darkTextPrimary = Color(0xFFF8F9FA);
  static const Color darkTextSecondary = Color(0xFFA0AEC0);
  static const Color darkBorder = Color(0xFF333342);

  // Status Colors
  static const Color success = Color(0xFF38B000);
  static const Color warning = Color(0xFFFFB703);
  static const Color error = Color(0xFFE63946);
  static const Color info = Color(0xFF219EBC);

  // Template Gradients
  static const LinearGradient royalGoldGradient = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFF5E086), Color(0xFFAA820A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient maroonGoldGradient = LinearGradient(
    colors: [Color(0xFF5E0B25), Color(0xFF8B1E3F), Color(0xFFD4AF37)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient modernGradient = LinearGradient(
    colors: [Color(0xFF1D3557), Color(0xFF457B9D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient floralGradient = LinearGradient(
    colors: [Color(0xFFFFF0F5), Color(0xFFFFE4E1)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
