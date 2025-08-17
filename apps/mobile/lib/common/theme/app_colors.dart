import 'dart:ui';

class AppColors {
  AppColors._();

  // Primary Colors - Based on your app's blue theme
  static const primary = Color(0xFF1976D2); // Main blue from your bottom nav
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFFE3F2FD);
  static const onPrimaryContainer = Color(0xFF0D47A1);

  // Background Colors - Clean and modern
  static const background = Color(0xFFFAFAFA);
  static const onBackground = Color(0xFF212121);
  static const surface = Color(0xFFFFFFFF);
  static const onSurface = Color(0xFF212121);
  static const surfaceVariant = Color(0xFFF5F5F5);
  static const onSurfaceVariant = Color(0xFF757575);

  // Text Colors - High contrast for readability
  static const text = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);
  static const textTertiary = Color(0xFF9E9E9E);
  static const hint = Color(0xFFBDBDBD);
  static const textDisabled = Color(0xFFE0E0E0);

  // Accent Colors - Purple for FAB, matching your app
  static const accent = Color(0xFFFF3333); // Red accent color for links and buttons
  static const onAccent = Color(0xFFFFFFFF);
  static const secondary = Color(0xFF03DAC6);
  static const onSecondary = Color(0xFF000000);

  // Status Colors - Professional and accessible
  static const success = Color(0xFF4CAF50);
  static const onSuccess = Color(0xFFFFFFFF);
  static const warning = Color(0xFFFF9800);
  static const onWarning = Color(0xFF000000);
  static const error = Color(0xFFF44336);
  static const onError = Color(0xFFFFFFFF);
  static const info = Color(0xFF2196F3);
  static const onInfo = Color(0xFFFFFFFF);

  // Neutral Colors - Clean grays
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const grey = Color(0xFF9E9E9E);
  static const lightGrey = Color(0xFFE0E0E0);
  static const darkGrey = Color(0xFF424242);
  static const transparent = Color(0x00000000);

  // Map-inspired Colors - Based on your app's map interface
  static const mapLand = Color(0xFFE8F5E8); // Light green for land
  static const mapWater = Color(0xFFE3F2FD); // Light blue for water
  static const mapRoad = Color(0xFFF5F5F5); // Light gray for roads
  static const mapHighway = Color(0xFF1976D2); // Blue for highways
  static const mapMarker = Color(0xFFF44336); // Red for markers
  static const mapPark = Color(0xFF4CAF50); // Green for parks

  // Gradient Colors - Professional gradients
  static const gradientStart = Color(0xFF1976D2);
  static const gradientEnd = Color(0xFF0D47A1);
  static const gradientLightStart = Color(0xFFE3F2FD);
  static const gradientLightEnd = Color(0xFFF3E5F5);

  // Border Colors - Subtle and clean
  static const border = Color(0xFFE0E0E0);
  static const borderLight = Color(0xFFF0F0F0);
  static const borderDark = Color(0xFFBDBDBD);

  // Shadow Colors - Subtle shadows
  static const shadow = Color(0x1A000000);
  static const shadowLight = Color(0x0A000000);
  static const shadowDark = Color(0x33000000);

  // Overlay Colors - For modals and dialogs
  static const overlay = Color(0x80000000);
  static const overlayLight = Color(0x40000000);

  // Search Bar Colors - Based on your app's search bar
  static const searchBarBackground = Color(0xFF424242);
  static const searchBarText = Color(0xFFE0E0E0);
  static const searchBarHint = Color(0xFF9E9E9E);
  static const searchBarIcon = Color(0xFFFFFFFF);

  // Filter Button Colors - Based on your app's filter buttons
  static const filterSelected = Color(0xFF1976D2);
  static const filterUnselected = Color(0xFF000000);
  static const filterText = Color(0xFFFFFFFF);

  // Bottom Navigation Colors - Based on your app's bottom nav
  static const bottomNavBackground = Color(0xFF1976D2);
  static const bottomNavSelected = Color(0xFFFFFFFF);
  static const bottomNavUnselected = Color(0xFFBBDEFB);

  // Floating Action Button Colors - Based on your app's FAB
  static const fabBackground = Color(0xFF9C27B0);
  static const fabIcon = Color(0xFFFFFFFF);

  // Map Control Colors - Based on your app's map controls
  static const mapControlBackground = Color(0xFF000000);
  static const mapControlIcon = Color(0xFFFFFFFF);

  // Legacy Colors (keeping for backward compatibility)
  static const dark = Color(0xFF121212);
  static const darkGray = Color(0xFF1E1E1E);
  static const lightGray = Color(0xFF333333);
  static const red = Color(0xFFFF0000);

  // Material Design 3 inspired colors
  static const primaryLight = Color(0xFF64B5F6);
  static const primaryDark = Color(0xFF1565C0);
  static const surfaceDim = Color(0xFFF5F5F5);
  static const surfaceBright = Color(0xFFFFFFFF);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const surfaceContainerLow = Color(0xFFFEFEFE);
  static const surfaceContainer = Color(0xFFF8F8F8);
  static const surfaceContainerHigh = Color(0xFFF2F2F2);
  static const surfaceContainerHighest = Color(0xFFECECEC);

  // Semantic Colors
  static const link = Color(0xFF1976D2);
  static const visited = Color(0xFF7B1FA2);
  static const focus = Color(0xFF2196F3);
  static const selected = Color(0xFFE3F2FD);
  static const hover = Color(0xFFF5F5F5);
  static const pressed = Color(0xFFE0E0E0);

  // Brand Colors - Matching your app's theme
  static const brandPrimary = Color(0xFF1976D2);
  static const brandSecondary = Color(0xFF9C27B0);
  static const brandAccent = Color(0xFF03DAC6);

  // Accessibility Colors
  static const highContrast = Color(0xFF000000);
  static const lowContrast = Color(0xFF757575);
  static const mediumContrast = Color(0xFF424242);

  // Dark Theme Colors - For future dark mode support
  static const darkBackground = Color(0xFF121212);
  static const darkSurface = Color(0xFF1E1E1E);
  static const darkPrimary = Color(0xFF90CAF9);
  static const darkText = Color(0xFFFFFFFF);
  static const darkTextSecondary = Color(0xFFB0B0B0);

  // Light Theme Colors
  static const lightBackground = Color(0xFFFAFAFA);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightPrimary = Color(0xFF1976D2);
  static const lightText = Color(0xFF212121);
  static const lightTextSecondary = Color(0xFF757575);
  static const lightCard = Color(0xFFFFFFFF);
  static const lightBorder = Color(0xFFE0E0E0);

  // Dark Theme Colors
  static const darkCard = Color(0xFF1E1E1E);
  static const darkBorder = Color(0xFF2A2A2A);
}

// Theme-aware color getters
extension AppColorsTheme on AppColors {
  static Color getBackground(bool isDark) => isDark ? AppColors.darkBackground : AppColors.lightBackground;
  static Color getSurface(bool isDark) => isDark ? AppColors.darkSurface : AppColors.lightSurface;
  static Color getCard(bool isDark) => isDark ? AppColors.darkCard : AppColors.lightCard;
  static Color getBorder(bool isDark) => isDark ? AppColors.darkBorder : AppColors.lightBorder;
  static Color getText(bool isDark) => isDark ? AppColors.darkText : AppColors.lightText;
  static Color getTextSecondary(bool isDark) => isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
}