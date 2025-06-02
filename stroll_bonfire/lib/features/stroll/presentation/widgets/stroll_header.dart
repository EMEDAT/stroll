import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

/// Stroll Header Widget - Header component with app title and stats
class StrollHeader extends StatelessWidget {
  const StrollHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Stroll Bonfire',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        _buildStatsRow(),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatItem(Icons.location_on_outlined, '2 km'),
        SizedBox(width: 16.w),
        _buildStatItem(Icons.people_outline, '103'),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.white70,
          size: 16.sp,
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(
            color: AppColors.white70,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}