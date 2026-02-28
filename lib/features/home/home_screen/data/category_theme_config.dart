import 'package:flutter/material.dart';
import 'package:teachers_app/gen/assets.gen.dart';

/// Configuration for category-specific theming including background images and overlay colors
class CategoryThemeConfig {
  final String categoryName;
  final AssetGenImage backgroundImage;
  final Color overlayColor;
  final double imageOpacity;
  final double overlayStartOpacity;
  final double overlayEndOpacity;

  const CategoryThemeConfig({
    required this.categoryName,
    required this.backgroundImage,
    required this.overlayColor,
    this.imageOpacity = 0.2,
    this.overlayStartOpacity = 0.6,
    this.overlayEndOpacity = 0.3,
  });
}

/// Predefined category themes
class CategoryThemes {
  static final Map<String, CategoryThemeConfig> _themes = {
    'academics': CategoryThemeConfig(
      categoryName: 'Academics',
      backgroundImage: Assets.images.tileBg,
      overlayColor: const Color(0xFFE8EAF6), // Light indigo
    ),
    'downloads': CategoryThemeConfig(
      categoryName: 'Downloads',
      backgroundImage: Assets.images.tileBg,
      overlayColor: const Color(0xFFFFF3E0), // Light orange
    ),
    'exam & results': CategoryThemeConfig(
      categoryName: 'Exam & Results',
      backgroundImage: Assets.images.tileBg,
      overlayColor: const Color(0xFFE8F5E9), // Light green
    ),
    'social media': CategoryThemeConfig(
      categoryName: 'Social Media',
      backgroundImage: Assets.images.tileBg,
      overlayColor: const Color(0xFFE3F2FD), // Light blue
    ),
  };

  /// Default theme for categories not explicitly configured
  static final CategoryThemeConfig defaultTheme = CategoryThemeConfig(
    categoryName: 'Default',
    backgroundImage: Assets.images.tileBg,
    overlayColor: const Color(0xFFF5F5F5), // Light grey
  );

  /// Get theme configuration for a specific category
  static CategoryThemeConfig getTheme(String categoryTitle) {
    final normalizedTitle = categoryTitle.toLowerCase().trim();
    return _themes[normalizedTitle] ?? defaultTheme;
  }

  /// Check if a category has a custom theme
  static bool hasCustomTheme(String categoryTitle) {
    final normalizedTitle = categoryTitle.toLowerCase().trim();
    return _themes.containsKey(normalizedTitle);
  }

  /// Register a new category theme or update an existing one
  /// This allows dynamic theme registration in the future
  static void registerTheme(String categoryTitle, CategoryThemeConfig config) {
    final normalizedTitle = categoryTitle.toLowerCase().trim();
    _themes[normalizedTitle] = config;
  }
}
