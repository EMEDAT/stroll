import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';

/// Action Buttons Widget - Bottom action buttons (mic, next)
class ActionButtons extends StatelessWidget {
  final bool isNextEnabled;
  final bool isProcessing;
  final VoidCallback onSkip;
  final VoidCallback onMic;
  final VoidCallback onNext;

  const ActionButtons({
    super.key,
    required this.isNextEnabled,
    required this.isProcessing,
    required this.onSkip,
    required this.onMic,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionButton(
          iconPath: '/icons/microphone.svg',
          fallbackIcon: Icons.mic,
          color: AppColors.micBlue,
          onTap: onMic,
          isEnabled: !isProcessing,
        ),
        ActionButton(
          iconPath: '/icons/next.svg',
          fallbackIcon: Icons.arrow_forward,
          color: AppColors.acceptGreen,
          onTap: isNextEnabled && !isProcessing ? onNext : null,
          isEnabled: isNextEnabled && !isProcessing,
        ),
      ],
    );
  }
}

/// Action Button Widget - Individual circular action button with better error handling
class ActionButton extends StatelessWidget {
  final String iconPath;
  final IconData fallbackIcon;
  final Color color;
  final VoidCallback? onTap;
  final bool isEnabled;

  const ActionButton({
    super.key,
    required this.iconPath,
    required this.fallbackIcon,
    required this.color,
    this.onTap,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: ResponsiveUtils.actionButtonSize.width,
        height: ResponsiveUtils.actionButtonSize.height,
        decoration: BoxDecoration(
          color: isEnabled ? color : color.withValues(alpha: 0.5),
          shape: BoxShape.circle,
          boxShadow: isEnabled ? [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ] : null,
        ),
        child: Center(
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
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                );
              }
              
              // Fallback to Flutter icon
              return Icon(
                fallbackIcon,
                color: AppColors.white,
                size: 28.sp,
              );
            },
          ),
        ),
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