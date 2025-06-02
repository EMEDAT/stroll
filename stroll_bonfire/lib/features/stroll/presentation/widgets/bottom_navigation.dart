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
      children: [
        Expanded(
          child: Center(
            child: NavIcon('assets/icons/cards.svg', Icons.credit_card, false),
          ),
        ),
        Expanded(
          child: Center(
            child: NavIcon('assets/icons/fire.svg', Icons.local_fire_department, true),
          ),
        ),
        Expanded(
          child: Center(
            child: NavIcon('assets/icons/chat.svg', Icons.chat_bubble_outline, false),
          ),
        ),
        Expanded(
          child: Center(
            child: NavIcon('assets/icons/user.svg', Icons.person_outline, false),
          ),
        ),
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
      padding: EdgeInsets.all(12.w), // Increased padding for larger touch area
      child: FutureBuilder<bool>(
        future: _assetExists(context, iconPath),
        builder: (context, snapshot) {
          // If asset exists, use SVG
          if (snapshot.hasData && snapshot.data == true) {
            return SvgPicture.asset(
              iconPath,
              width: _getIconSize(),
              height: _getIconSize(),
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
            size: _getIconSize(),
          );
        },
      ),
    );
  }

  // Specific sizing for user icon to match others
  double _getIconSize() {
    if (iconPath.contains('user.svg')) {
      return 45.w; // Larger size specifically for user icon
    }
    if (iconPath.contains('fire.svg')) {
      return 30.w; // Slightly larger for fire icon
    }
    if (iconPath.contains('chat.svg')) {
      return 25.w; // Slightly larger for chat icon
    }
    return 29.w; // Default size for other icons
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