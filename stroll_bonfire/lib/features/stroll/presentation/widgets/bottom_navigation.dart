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
        NavIcon(Icons.home_outlined, false),
        NavIcon(Icons.explore_outlined, false),
        NavIcon(Icons.local_fire_department, true), // Active fire icon
        NavIcon(Icons.chat_bubble_outline, false),
        NavIcon(Icons.person_outline, false),
      ],
    );
  }
}

/// Navigation Icon Widget - Individual navigation icon
class NavIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;

  const NavIcon(this.icon, this.isActive, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.all(8.w),
      child: Icon(
        icon,
        color: isActive ? AppColors.white : AppColors.white60,
        size: 28.sp,
      ),
    );
  }
}