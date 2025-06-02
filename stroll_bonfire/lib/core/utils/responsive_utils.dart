import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Responsive Utils - Helper methods for responsive design
class ResponsiveUtils {
  // Private constructor to prevent instantiation
  ResponsiveUtils._();

  // Device type checks
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 768;
  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1024;

  // Screen dimensions
  static double get screenWidth => 1.sw;
  static double get screenHeight => 1.sh;

  // Responsive sizing
  static double width(double size) => size.w;
  static double height(double size) => size.h;
  static double fontSize(double size) => size.sp;
  static double radius(double size) => size.r;

  // Dynamic spacing based on screen size
  static double getResponsiveSpacing(double baseSpacing) {
    if (1.sw < 375) return baseSpacing * 0.8; // Small phones
    if (1.sw > 414) return baseSpacing * 1.2; // Large phones
    return baseSpacing;
  }

  // Dynamic font sizes
  static double getResponsiveFontSize(double baseFontSize) {
    if (1.sw < 375) return baseFontSize * 0.9;
    if (1.sw > 414) return baseFontSize * 1.1;
    return baseFontSize;
  }

  // Padding utilities
  static EdgeInsets padding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    if (all != null) return EdgeInsets.all(all.w);
    return EdgeInsets.only(
      top: (top ?? vertical ?? 0).h,
      bottom: (bottom ?? vertical ?? 0).h,
      left: (left ?? horizontal ?? 0).w,
      right: (right ?? horizontal ?? 0).w,
    );
  }

  // Safe area utilities
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return EdgeInsets.only(
      top: padding.top,
      bottom: padding.bottom,
    );
  }

  // Component specific sizes
  static EdgeInsets get defaultScreenPadding => EdgeInsets.symmetric(
        horizontal: getResponsiveSpacing(20.w),
        vertical: getResponsiveSpacing(16.h),
      );

  static Size get actionButtonSize => Size(
        getResponsiveSpacing(64.w),
        getResponsiveSpacing(64.h),
      );

  static double get profileImageSize => getResponsiveSpacing(64.w);

  static EdgeInsets get cardPadding => EdgeInsets.all(getResponsiveSpacing(20.w));

  static BorderRadius get cardBorderRadius => BorderRadius.circular(getResponsiveSpacing(20.r));

  static BorderRadius get buttonBorderRadius => BorderRadius.circular(getResponsiveSpacing(16.r));
}