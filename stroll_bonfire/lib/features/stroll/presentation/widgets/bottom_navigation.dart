import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';

/// Bottom Navigation Widget - App bottom navigation bar  
class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        NavIcon('/icons/cards.svg', Icons.credit_card, false),
        NavIcon('/icons/chat.svg', Icons.chat_bubble_outline, false), 
        NavIcon('/icons/fire.svg', Icons.local_fire_department, true),
        NavIcon('/icons/user.svg', Icons.person_outline, false),
      ],
    );
  }
}

/// Navigation Icon Widget - Individual navigation icon with better error handling
class NavIcon extends StatelessWidget {
  final String iconPath;
  final IconData fallbackIcon;
  final bool isActive;

  const NavIcon(this.iconPath, this.fallbackIcon, this.isActive, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.all(8.w),
      child: FutureBuilder<bool>(
        future: _assetExists(context, iconPath),
        builder: (context, snapshot) {
          // If asset exists, use SVG
          if (snapshot.hasData && snapshot.data == true) {
            return SvgPicture.asset(
              iconPath,
              width: 28.w,
              height: 28.w,
              colorFilter: ColorFilter.mode(
                isActive ? AppColors.white : AppColors.white60,
                BlendMode.srcIn,
              ),
            );
          }
          
          // Fallback to Flutter icon
          return Icon(
            fallbackIcon,
            color: isActive ? AppColors.white : AppColors.white60,
            size: 28.sp,
          );
        },
      ),
    );
  }

  Future<bool> _assetExists(BuildContext context, String path) async {
    try {
      await DefaultAssetBundle.of(context).load(path);
      return true;
    } catch (e) {
      debugPrint('Asset not found: $path');
      return false;
    }
  }
}