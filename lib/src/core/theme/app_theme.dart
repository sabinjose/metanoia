import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Premium Spiritual Color Palette
  // Light theme: Warm, peaceful, reverent
  // Dark theme: Contemplative, serene, elegant

  // Primary: Deep Royal Purple (from logo background)
  static const _primaryLight = Color(0xFF7558A3); // Richer Royal Purple
  static const _primaryDark = Color(0xFF9D7FCC); // Softer Light Purple

  // Secondary: Warm Gold with Orange tones (from cross & flame)
  static const _secondaryLight = Color(0xFFD4A545); // Rich Warm Gold
  static const _secondaryDark = Color(0xFFF3CB5C); // Balanced Warm Gold

  // Accent: Deep Purple (logo background shadow)
  static const _accentPurple = Color(0xFF2D0055); // Deep Purple
  static const _accentPurpleDark = Color(0xFF5B3A7C); // Lighter for dark mode

  // Tertiary: For special accents
  static const _tertiaryLight = Color(0xFFB76E79); // Muted Rose-Gold
  static const _tertiaryDark = Color(0xFFB794D6); // Soft Lavender (dark mode)

  // Surface colors - carefully chosen for readability and peace
  static const _surfaceLight = Color(0xFFFCFBF9); // Richer warm off-white
  static const _cardLight = Color(0xFFFFFFFF); // Pure white cards
  static const _backgroundLight = Color(0xFFF8F6F3); // Warmer subtle grey

  static const _surfaceDark = Color(
    0xFF1C1626,
  ); // Deep purple-tinted dark (lighter)
  static const _cardDark = Color(0xFF272134); // Purple-tinted cards (lighter)
  static const _backgroundDark = Color(0xFF121019); // Deep purple-black

  static TextTheme _buildTextTheme(TextTheme base) {
    return GoogleFonts.latoTextTheme(base).copyWith(
      displayLarge: GoogleFonts.lato(
        textStyle: base.displayLarge,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      displayMedium: GoogleFonts.lato(
        textStyle: base.displayMedium,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      displaySmall: GoogleFonts.lato(
        textStyle: base.displaySmall,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.25,
      ),
      titleLarge: GoogleFonts.lato(
        textStyle: base.titleLarge,
        fontWeight: FontWeight.bold,
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.lato(
        textStyle: base.titleMedium,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.15,
      ),
      bodyLarge: GoogleFonts.lato(
        textStyle: base.bodyLarge,
        letterSpacing: 0.5,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.lato(
        textStyle: base.bodyMedium,
        letterSpacing: 0.25,
        height: 1.6,
      ),
    );
  }

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: _primaryLight,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFE5DBEF), // Richer lavender
      onPrimaryContainer: _accentPurple, // Deep Purple
      secondary: _secondaryLight,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFF8E8C8), // Richer cream-gold
      onSecondaryContainer: Color(0xFF3D2800), // Darker brown
      tertiary: _tertiaryLight,
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFF4E0E4), // Soft rose
      onTertiaryContainer: Color(0xFF4A1F29), // Deep rose-brown
      surface: _surfaceLight,
      onSurface: Color(0xFF1C1B1F),
      surfaceContainerHighest: Color(0xFFEBE7E3), // Warmer grey
      surfaceContainer: Color(0xFFF5F2EE), // Mid-tone
      surfaceContainerLow: Color(0xFFF9F7F4), // Subtle
      outline: Color(0xFFC4BEC8), // Purple-tinted
      outlineVariant: Color(0xFFE3DED8), // Warm-tinted
      error: Color(0xFFB3261E), // Material 3 error
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _backgroundLight,
      textTheme: _buildTextTheme(ThemeData.light().textTheme),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: _primaryLight,
        titleTextStyle: GoogleFonts.lato(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: _primaryLight,
          letterSpacing: 0.15,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
        color: _cardLight,
        shadowColor: Colors.black.withValues(alpha: 0.05),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryLight,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: _primaryLight.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _secondaryLight,
        foregroundColor: Color(0xFF3E2723),
        elevation: 4,
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.lato(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _primaryLight,
            );
          }
          return GoogleFonts.lato(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF1C1B1F),
          );
        }),
      ),
    );
  }

  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: _primaryDark,
      onPrimary: Color(0xFF1C1626), // Dark purple text on light purple
      primaryContainer: _accentPurpleDark, // Lighter deep purple
      onPrimaryContainer: Color(0xFFE8DFF5), // Very light lavender
      secondary: _secondaryDark,
      onSecondary: Color(0xFF1C1626), // Dark purple text on gold
      secondaryContainer: Color(0xFF6B5427), // Muted gold-brown
      onSecondaryContainer: Color(0xFFFFF4D9), // Very light gold
      tertiary: _tertiaryDark,
      onTertiary: Color(0xFF1C1626),
      tertiaryContainer: Color(0xFF4A3C5F), // Muted purple
      onTertiaryContainer: Color(0xFFE8DFF5),
      surface: _surfaceDark,
      onSurface: Color(0xFFE8E3EB), // Slightly warmer white
      surfaceContainerHighest: Color(0xFF322B3D), // Lighter purple-tinted
      outline: Color(0xFF9D92A3), // Softer outline
      outlineVariant: Color(0xFF463F4E), // Purple-tinted variant
      error: Color(0xFFFFB4AB), // Softer red
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _backgroundDark,
      textTheme: _buildTextTheme(ThemeData.dark().textTheme),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: _primaryDark,
        titleTextStyle: GoogleFonts.lato(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: _primaryDark,
          letterSpacing: 0.15,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
        color: _cardDark,
        shadowColor: Colors.black.withValues(alpha: 0.3),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _secondaryDark,
          foregroundColor: const Color(0xFF1A1A1A),
          elevation: 2,
          shadowColor: _secondaryDark.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _secondaryDark,
        foregroundColor: Color(0xFF1A1A1A),
        elevation: 4,
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.lato(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _secondaryDark,
            );
          }
          return GoogleFonts.lato(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: const Color(0xFFE6E1E5),
          );
        }),
      ),
    );
  }
}
