import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';

/// Action Buttons Widget - Bottom action buttons (skip, mic, next)
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
          icon: Icons.mic,
          color: AppColors.micBlue,
          onTap: onMic,
          isEnabled: !isProcessing,
        ),
        ActionButton(
          icon: isProcessing ? Icons.hourglass_empty : Icons.arrow_forward,
          color: AppColors.acceptGreen,
          onTap: isNextEnabled && !isProcessing ? onNext : null,
          isEnabled: isNextEnabled && !isProcessing,
        ),
      ],
    );
  }
}

/// Action Button Widget - Individual circular action button
class ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final bool isEnabled;

  const ActionButton({
    super.key,
    required this.icon,
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
        child: Icon(
          icon,
          color: AppColors.white,
          size: 28.sp,
        ),
      ),
    );
  }
}