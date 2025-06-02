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
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  Color(0xFFB794F6),
                  Color(0xFF9F7AEA),
                ],
              ).createShader(bounds),
              child: Text(
                'Stroll Bonfire',
                style: TextStyle(
                  fontSize: 34.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.white70,
              size: 24.sp,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        // Stats below title
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatItem(Icons.access_time, '22h 00m'),
            SizedBox(width: 24.w),
            _buildStatItem(Icons.people, '103'),
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
          size: 16.sp,
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(
            color: AppColors.white70,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}