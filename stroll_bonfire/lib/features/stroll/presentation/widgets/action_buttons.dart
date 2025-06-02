import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';

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
      mainAxisAlignment: MainAxisAlignment.center, // ← CHANGED
      children: [
        ActionButton(
          iconPath: 'assets/icons/microphone.svg',
          fallbackIcon: Icons.mic,
          onTap: onMic,
          isEnabled: !isProcessing,
          isNextButton: false,
        ),
        SizedBox(width: 6.w), // ← ADD THIS GAP
        ActionButton(
          iconPath: 'assets/icons/next.svg',
          fallbackIcon: Icons.arrow_forward,
          onTap: isNextEnabled && !isProcessing ? onNext : null,
          isEnabled: isNextEnabled && !isProcessing,
          isNextButton: true,
        ),
      ],
    );
  }
}

/// Action Button Widget - Displays SVG as-is for mic, custom styling for next button
class ActionButton extends StatelessWidget {
  final String iconPath;
  final IconData fallbackIcon;
  final VoidCallback? onTap;
  final bool isEnabled;
  final bool isNextButton;

  const ActionButton({
    super.key,
    required this.iconPath,
    required this.fallbackIcon,
    this.onTap,
    this.isEnabled = true,
    this.isNextButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: isNextButton ? _buildNextButton() : _buildRegularButton(),
    );
  }

  Widget _buildNextButton() {
    return Container(
      width: 40.w, // Reduced from ResponsiveUtils.actionButtonSize.width
      height: 40.w, // Reduced from ResponsiveUtils.actionButtonSize.height
      decoration: BoxDecoration(
        color: const Color(0xFF8B88EF), // Always full color, no fading
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.arrow_forward,
          color: Colors.black,
          size: 28.sp, // Reduced from 32.sp
        ),
      ),
    );
  }

  Widget _buildRegularButton() {
    return SizedBox(
      width: 40.w, // Reduced size
      height: 40.w, // Reduced size
      child: Builder(
        builder: (context) => FutureBuilder<bool>(
          future: _assetExists(context, iconPath),
          builder: (context, snapshot) {
            // If asset exists, use SVG exactly as imported
            if (snapshot.hasData && snapshot.data == true) {
              return SvgPicture.asset(
                iconPath,
                width: 40.w, // Reduced size
                height: 40.w, // Reduced size
                fit: BoxFit.contain,
              );
            }
            
            // Fallback to Flutter icon
            return Container(
              width: 48.w, // Reduced size
              height: 48.w, // Reduced size
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: Icon(
                fallbackIcon,
                color: AppColors.white,
                size: 24.sp, // Reduced from 28.sp
              ),
            );
          },
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