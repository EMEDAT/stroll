import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Bottom Navigation Widget - App bottom navigation bar with WHITE BACKGROUND
class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // FULL SCREEN WIDTH
      color: const Color(0xFF0F1115), // #0F1115 BACKGROUND
      padding: EdgeInsets.symmetric(vertical: 12.h), // NO horizontal padding, only vertical
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Use spaceEvenly for wider spread
        children: [
          NavIcon('assets/icons/cards.svg', Icons.credit_card, false),
          NavIcon('assets/icons/fire.svg', Icons.local_fire_department, true),
          NavIcon('assets/icons/chat.svg', Icons.chat_bubble_outline, false), 
          NavIcon('assets/icons/user.svg', Icons.person_outline, false),
        ],
      ),
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
      padding: EdgeInsets.all(12.w),
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
                isActive ? Colors.white : Colors.grey, // White for active, grey for inactive on dark background
                BlendMode.srcIn,
              ),
            );
          }
          
          // Fallback to Flutter icon
          return Icon(
            fallbackIcon,
            color: isActive ? Colors.white : Colors.grey, // White for active, grey for inactive on dark background
            size: _getIconSize(),
          );
        },
      ),
    );
  }

  // Specific sizing for user icon to match others
  double _getIconSize() {
    if (iconPath.contains('user.svg')) {
      return 45.w;
    }
    if (iconPath.contains('fire.svg')) {
      return 30.w;
    }
    if (iconPath.contains('chat.svg')) {
      return 25.w;
    }
    return 29.w;
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