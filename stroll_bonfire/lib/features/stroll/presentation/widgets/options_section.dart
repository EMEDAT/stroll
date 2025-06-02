import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../domain/entities/question.dart';

/// Options Section Widget - Displays question options
class OptionsSection extends StatelessWidget {
  final List<QuestionOption> options;
  final int selectedIndex;
  final Function(int) onOptionSelected;

  const OptionsSection({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pick your option.\nSee who has a similar mind.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(height: 24.h),
        ...options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          final isSelected = selectedIndex == index;
          
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: OptionCard(
              option: option,
              isSelected: isSelected,
              onTap: () => onOptionSelected(index),
            ),
          );
        }),
      ],
    );
  }
}

/// Option Card Widget - Individual option card
class OptionCard extends StatelessWidget {
  final QuestionOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.glassmorphismSelected 
              : AppColors.glassmorphismBackground,
          borderRadius: ResponsiveUtils.buttonBorderRadius,
          border: Border.all(
            color: isSelected 
                ? AppColors.glassmorphismSelectedBorder 
                : AppColors.glassmorphismBorder,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ] : null,
        ),
        child: Row(
          children: [
            _buildOptionIcon(),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                option.text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionIcon() {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: option.backgroundColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(
        option.icon,
        color: AppColors.white,
        size: 20.sp,
      ),
    );
  }
}