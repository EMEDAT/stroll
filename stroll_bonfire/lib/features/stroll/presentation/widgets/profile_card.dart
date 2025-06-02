import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/question.dart';

/// Profile Card Widget - Displays user profile and question
class ProfileCard extends StatelessWidget {
  final User user;
  final Question question;

  const ProfileCard({
    super.key,
    required this.user,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ResponsiveUtils.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.glassmorphismBackground,
        borderRadius: ResponsiveUtils.cardBorderRadius,
        border: Border.all(
          color: AppColors.glassmorphismBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildProfileImage(),
          SizedBox(width: 16.w),
          Expanded(
            child: _buildUserInfo(context),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      children: [
        Container(
          width: ResponsiveUtils.profileImageSize,
          height: ResponsiveUtils.profileImageSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: user.isOnline ? AppColors.onlineGreen : AppColors.white40,
              width: 3,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/profileImage.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.white20,
                  child: Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: 32.sp,
                  ),
                );
              },
            ),
          ),
        ),
        if (user.isOnline)
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              width: 12.w,
              height: 12.w,
              decoration: const BoxDecoration(
                color: AppColors.onlineGreen,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${user.name}, ${user.age}',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(height: 8.h),
        Text(
          question.text,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 6.h),
        Text(
          '"${question.authorAnswer}"',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}