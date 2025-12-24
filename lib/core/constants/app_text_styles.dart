import 'package:flutter/material.dart';
import 'app_colors.dart';

/// App Text Styles - Centralized text style constants (no hardcoding in widgets)
/// Poppins is the primary font, Montserrat for larger headings.
class AppTextStyles {
  // Base helpers
  static TextStyle _poppins({
    required double size,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.textPrimary,
    double? height,
  }) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
  );

  static TextStyle _montserrat({
    required double size,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.textPrimary,
    double? height,
  }) => TextStyle(
    fontFamily: 'Montserrat',
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
  );

  // Display / Headings use Montserrat
  static final TextStyle displayLarge = _montserrat(
    size: 36,
    weight: FontWeight.bold,
    height: 1.2,
  );
  static final TextStyle displayMedium = _montserrat(
    size: 32,
    weight: FontWeight.bold,
    height: 1.2,
  );
  static final TextStyle displaySmall = _montserrat(
    size: 28,
    weight: FontWeight.bold,
    height: 1.2,
  );

  static final TextStyle headlineLarge = _montserrat(
    size: 24,
    weight: FontWeight.bold,
    height: 1.3,
  );
  static final TextStyle headlineMedium = _montserrat(
    size: 22,
    weight: FontWeight.w600,
    height: 1.3,
  );
  static final TextStyle headlineSmall = _montserrat(
    size: 20,
    weight: FontWeight.w600,
    height: 1.3,
  );

  // Titles use Montserrat
  static final TextStyle titleLarge = _montserrat(
    size: 19,
    weight: FontWeight.w600,
    height: 1.4,
  );
  static final TextStyle titleMedium = _montserrat(
    size: 17,
    weight: FontWeight.w500,
    height: 1.4,
  );
  static final TextStyle titleSmall = _montserrat(
    size: 16,
    weight: FontWeight.w500,
    height: 1.4,
  );

  // Body uses Poppins
  static final TextStyle bodyLarge = _poppins(
    size: 17,
    weight: FontWeight.w400,
    height: 1.5,
  );
  static final TextStyle bodyMedium = _poppins(
    size: 16,
    weight: FontWeight.w400,
    height: 1.5,
  );
  static final TextStyle bodySmall = _poppins(
    size: 14,
    weight: FontWeight.w400,
    height: 1.5,
  );

  // Labels use Poppins
  static final TextStyle labelLarge = _poppins(
    size: 16,
    weight: FontWeight.w500,
    height: 1.4,
  );
  static final TextStyle labelMedium = _poppins(
    size: 14,
    weight: FontWeight.w500,
    height: 1.4,
  );
  static final TextStyle labelSmall = _poppins(
    size: 12,
    weight: FontWeight.w500,
    height: 1.4,
  );

  // Captions
  static final TextStyle caption = _poppins(
    size: 12,
    weight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );
  static final TextStyle captionSmall = _poppins(
    size: 10,
    weight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // Buttons
  static final TextStyle button = _poppins(
    size: 17,
    weight: FontWeight.w600,
    color: AppColors.textWhite,
    height: 1.2,
  );
  static final TextStyle buttonSmall = _poppins(
    size: 14,
    weight: FontWeight.w600,
    color: AppColors.textWhite,
    height: 1.2,
  );

  /// Convenience TextTheme
  static TextTheme get textTheme => TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );
}
