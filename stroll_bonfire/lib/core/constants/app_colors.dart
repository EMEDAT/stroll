import 'package:flutter/material.dart';

/// App Colors - All colors used throughout the application
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // White variants
  static const Color white = Color(0xFFFFFFFF);
  static const Color white90 = Color(0xE6FFFFFF);
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color white60 = Color(0x99FFFFFF);
  static const Color white40 = Color(0x66FFFFFF);
  static const Color white20 = Color(0x33FFFFFF);
  static const Color white15 = Color(0x26FFFFFF);
  static const Color white10 = Color(0x1AFFFFFF);
  
  // Primary brand colors
  static const Color primary = Color(0xFF8A2BE2);
  static const Color secondary = Color(0xFF61C3F2);
  
  // Action button colors - EXACT from design
  static const Color rejectRed = Color(0xFFE94057);
  static const Color micBlue = Color(0xFF8A2BE2);
  static const Color acceptGreen = Color(0xFF61C3F2);
  
  // Status colors
  static const Color onlineGreen = Color(0xFF4CAF50);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE94057);
  static const Color warning = Color(0xFFFFB347);
  static const Color info = Color(0xFF4FC3F7);
  
  // Option background colors - EXACT from design
  static const Color morningBg = Color(0xFFFF6B35);
  static const Color goldenBg = Color(0xFFFFB347);
  static const Color dinnerBg = Color(0xFF4FC3F7);
  static const Color midnightBg = Color(0xFF9C27B0);
  
  // Background gradient colors
  static const List<Color> backgroundGradient = [
    Color(0xFF8B9DC3), // Top blue
    Color(0xFFDDB892), // Orange
    Color(0xFFFFC397), // Light orange
  ];
  
  // Glassmorphism colors
  static Color glassmorphismBackground = white.withValues(alpha: 0.15);
  static Color glassmorphismBorder = white.withValues(alpha: 0.2);
  static Color glassmorphismSelected = white.withValues(alpha: 0.25);
  static Color glassmorphismSelectedBorder = white.withValues(alpha: 0.4);
}