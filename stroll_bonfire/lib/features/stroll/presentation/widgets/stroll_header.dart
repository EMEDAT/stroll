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
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  fontSize: 28.sp, // Reduced from 34
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.0,
                  letterSpacing: 0,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 3,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                    Shadow(
                      offset: Offset(0, 4),
                      blurRadius: 16,
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 6.w), // Reduced spacing
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
                size: 20.sp, // Reduced from 24
                shadows: [
                  Shadow(
                    offset: Offset(0, 2),
                    blurRadius: 8,
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h), // Reduced spacing
        // Stats below title
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatItem(Icons.access_time, '22h 00m'),
            SizedBox(width: 4.w), // Reduced spacing
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
          size: 12.sp, // Reduced from 15
          shadows: [
            Shadow(
              offset: Offset(0, 1),
              blurRadius: 4,
              color: Colors.black.withValues(alpha: 0.3),
            ),
          ],
        ),
        SizedBox(width: 3.w), // Reduced spacing
        Text(
          text,
          style: TextStyle(
            color: AppColors.white70,
            fontSize: 12.sp, // Reduced from 14
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 4,
                color: Colors.black.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}