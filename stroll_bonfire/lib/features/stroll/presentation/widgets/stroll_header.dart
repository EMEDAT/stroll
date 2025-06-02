import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

/// Stroll Header Widget - Header component with app title and stats
class StrollHeader extends StatelessWidget {
  const StrollHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main title with dropdown
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Vertical alignment middle
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFB3ADF6), // Top
                  Color(0xFFCBC9FF), // Middle
                  Color(0xFFCCC8FF), // Bottom
                ],
              ).createShader(bounds),
              child: Text(
                'Stroll Bonfire',
                style: TextStyle(
                  fontFamily: 'Proxima Nova',
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.0, // Line height 100%
                  letterSpacing: 0,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFB3ADF6), // Top
                  Color(0xFFCBC9FF), // Middle
                  Color(0xFFCCC8FF), // Bottom
                ],
              ).createShader(bounds),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        // Stats below title
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatItem(Icons.access_time, '22h 00m'),
            SizedBox(width: 6.w),
            _buildStatItem(Icons.person, '103'),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.white70,
          size: 15.sp,
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(
            color: AppColors.white70,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}