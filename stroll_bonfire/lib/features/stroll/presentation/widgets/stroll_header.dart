import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

/// Stroll Header Widget - Header component with app title and toggleable stats
class StrollHeader extends StatefulWidget {
  const StrollHeader({super.key});

  @override
  State<StrollHeader> createState() => _StrollHeaderState();
}

class _StrollHeaderState extends State<StrollHeader> {
  bool _isExpanded = false; // Track dropdown state

  void _toggleDropdown() {
    setState(() {
      _isExpanded = !_isExpanded; // Toggle the state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main title with dropdown button
        GestureDetector(
          onTap: _toggleDropdown, // Make the whole header clickable
          child: Row(
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
                    fontSize: 34.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.0,
                    letterSpacing: 0,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 2),
                        blurRadius: 1,
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
              SizedBox(width: 6.w),
              // Animated arrow icon
              AnimatedRotation(
                turns: _isExpanded ? 0.5 : 0.0, // Rotate 180 degrees when expanded
                duration: const Duration(milliseconds: 300),
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFB3ADF6),
                      Color(0xFFCBC9FF),
                      Color(0xFFCCC8FF),
                    ],
                  ).createShader(bounds),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 20.sp,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 2),
                        blurRadius: 8,
                        color: Colors.black.withValues(alpha: 0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Animated timer stats section
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: _isExpanded ? null : 0, // Expand or collapse
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _isExpanded ? 1.0 : 0.0, // Fade in/out
            child: _isExpanded 
                ? Column(
                    children: [
                      SizedBox(height: 6.h),
                      // Stats below title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildStatItem('icons/Timer.png', '22h 00m'),
                          SizedBox(width: 10.w),
                          _buildStatItem('icons/Top-man.png', '103'),
                        ],
                      ),
                    ],
                  )
                : const SizedBox.shrink(), // Empty when collapsed
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String imagePath, String text) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 16.w,  // Increased from 12.w
          height: 16.w, // Increased from 12.w
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // Fallback to icon if image fails to load
            IconData fallbackIcon = imagePath.contains('Timer') 
                ? Icons.access_time 
                : Icons.person;
            return Icon(
              fallbackIcon,
              color: AppColors.white70,
              size: 12.sp,
              shadows: [
                Shadow(
                  offset: Offset(0, 1),
                  blurRadius: 4,
                  color: Colors.black.withValues(alpha: 0.3),
                ),
              ],
            );
          },
        ),
        SizedBox(width: 3.w),
        Text(
          text,
          style: TextStyle(
            color: AppColors.white70,
            fontSize: 12.sp,
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