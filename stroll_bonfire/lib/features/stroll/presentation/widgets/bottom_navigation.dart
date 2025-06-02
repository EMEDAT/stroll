import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

/// Bottom Navigation Widget - App bottom navigation bar  
class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        NavIcon('assets/icons/cards.png', false),
        NavIcon('assets/icons/Chat.png', false), 
        NavIcon('assets/icons/Fire.png', true), // Active fire icon
        NavIcon('assets/icons/User.png', false),
      ],
    );
  }
}

/// Navigation Icon Widget - Individual navigation icon using PNG assets
class NavIcon extends StatelessWidget {
  final String iconPath;
  final bool isActive;

  const NavIcon(this.iconPath, this.isActive, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.all(8.w),
      child: Image.asset(
        iconPath,
        width: 28.w,
        height: 28.w,
        color: isActive ? AppColors.white : AppColors.white60,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to Flutter icons if PNG files don't load
          IconData fallbackIcon = Icons.home;
          if (iconPath.contains('Chat')) fallbackIcon = Icons.chat_bubble_outline;
          if (iconPath.contains('Fire')) fallbackIcon = Icons.local_fire_department;
          if (iconPath.contains('User')) fallbackIcon = Icons.person_outline;
          
          return Icon(
            fallbackIcon,
            color: isActive ? AppColors.white : AppColors.white60,
            size: 28.sp,
          );
        },
      ),
    );
  }
}