import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/question.dart';

/// Options Section Widget - Displays question options in 2x2 grid
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
        // 2x2 Grid of options
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: OptionCard(
                    option: options[0],
                    isSelected: selectedIndex == 0,
                    onTap: () => onOptionSelected(0),
                    label: 'A',
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OptionCard(
                    option: options[1],
                    isSelected: selectedIndex == 1,
                    onTap: () => onOptionSelected(1),
                    label: 'B',
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: OptionCard(
                    option: options[2],
                    isSelected: selectedIndex == 2,
                    onTap: () => onOptionSelected(2),
                    label: 'C',
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OptionCard(
                    option: options[3],
                    isSelected: selectedIndex == 3,
                    onTap: () => onOptionSelected(3),
                    label: 'D',
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// Option Card Widget - Individual option card with label
class OptionCard extends StatelessWidget {
  final QuestionOption option;
  final bool isSelected;
  final VoidCallback onTap;
  final String label;

  const OptionCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
    required this.label,
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
              ? Colors.blue.withValues(alpha: 0.3) 
              : Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.white.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Icon(
                  option.icon,
                  color: AppColors.white,
                  size: 20.sp,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              option.text,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}