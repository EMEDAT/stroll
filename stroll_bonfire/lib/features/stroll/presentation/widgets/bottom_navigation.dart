import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Bottom Navigation Widget - App bottom navigation bar with badges
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
          _buildIconWithBadge(
            NavIcon('assets/icons/fire.svg', Icons.local_fire_department, false), // Removed isFireIcon
            showDot: true, // Dot for fire icon
          ),
          _buildIconWithBadge(
            NavIcon('assets/icons/chat.svg', Icons.chat_bubble_outline, false),
            count: 10, // Count badge for chat icon
          ),
          NavIcon('assets/icons/user.svg', Icons.person_outline, false),
        ],
      ),
    );
  }

  // Helper method to add badges to icons
  Widget _buildIconWithBadge(Widget icon, {bool showDot = false, int? count}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        if (showDot) // Purple dot badge
          Positioned(
            top: 8.h,
            right: 8.w,
            child: Container(
              width: 8.w,
              height: 8.w,
              decoration: const BoxDecoration(
                color: Color(0xFFB5B2FF), // Background #B5B2FF
                shape: BoxShape.circle,
              ),
            ),
          ),
        if (count != null) // Purple count badge
          Positioned(
            top: 6.h,
            right: 6.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: const Color(0xFFB5B2FF), // Background #B5B2FF
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Navigation Icon Widget - Individual navigation icon (NON-CLICKABLE)
class NavIcon extends StatelessWidget {
  final String iconPath;
  final IconData fallbackIcon;
  final bool isActive;

  const NavIcon(this.iconPath, this.fallbackIcon, this.isActive, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container( // Static container, no animations or gestures
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
                Colors.grey, // All icons same grey color
                BlendMode.srcIn,
              ),
            );
          }
          
          // Fallback to Flutter icon
          return Icon(
            fallbackIcon,
            color: Colors.grey, // All icons same grey color
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