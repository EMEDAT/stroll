import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../cubit/stroll_cubit.dart';
import '../cubit/stroll_state.dart';
import '../widgets/stroll_header.dart';
import '../widgets/action_buttons.dart';
import '../widgets/bottom_navigation.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/user.dart';

/// Stroll Bonfire Page - Main screen for the stroll feature
class StrollBonfirePage extends StatelessWidget {
  const StrollBonfirePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background.jpg'),
            fit: BoxFit.fitWidth,
            alignment: Alignment(0.0, -1.5), // Push image way higher up
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.35, 0.6, 1.0], // More control points
              colors: [
                Colors.transparent, // Top stays transparent
                Colors.black.withValues(alpha: 0.2), // Light fade starts
                Colors.black.withValues(alpha: 0.8), // Heavy darkness in middle
                Colors.black.withValues(alpha: 1.0), // Complete black at bottom
              ],
            ),
          ),
          child: SafeArea(
            child: BlocBuilder<StrollCubit, StrollState>(
              builder: (context, state) {
                if (state is StrollLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  );
                }

                if (state is StrollError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (state is StrollLoaded) {
                  return _buildLoadedContent(context, state);
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadedContent(BuildContext context, StrollLoaded state) {
    return Column(
      children: [
        // Top section with header
        Expanded(
          flex: 75, // Reduced to make more room for bottom
          child: Padding(
            padding: ResponsiveUtils.defaultScreenPadding,
            child: Column(
              children: [
                const Spacer(flex: 1), // Push header down with spacer
                const StrollHeader(),
                const Spacer(flex: 3), // Small spacer at bottom
              ],
            ),
          ),
        ),
        // Bottom section with content
        Expanded(
          flex: 65, // Increased to accommodate more content
          child: Container(
            // Add extra dark overlay to bottom section for better readability
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.3),
                ],
              ),
            ),
            child: Padding(
              padding: ResponsiveUtils.defaultScreenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileSection(state.currentUser, state.currentQuestion),
                  SizedBox(height: 16.h),
                  _buildOptionsGrid(context, state),
                  SizedBox(height: 12.h),
                  _buildBottomSection(context, state),
                  SizedBox(height: 16.h),
                  const BottomNavigation(),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection(User user, Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile image and name
        Row(
          children: [
            _buildProfileImage(user),
            SizedBox(width: 12.w),
            Text(
              '${user.name}, ${user.age}',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        // Question text
        Text(
          question.text,
          style: TextStyle(
            fontSize: 20.sp, // Increased for better hierarchy
            fontWeight: FontWeight.w700,
            color: AppColors.white,
            height: 1.1,
          ),
        ),
        SizedBox(height: 8.h),
        // Author answer
        Text(
          '"${question.authorAnswer}"',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.white70,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage(User user) {
    return Stack(
      children: [
        Container(
          width: 50.w, // Slightly larger for better visibility
          height: 50.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
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
                    size: 28.sp,
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

  Widget _buildOptionsGrid(BuildContext context, StrollLoaded state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildOptionCard(
                context,
                state.currentQuestion.options[0],
                0,
                state.selectedOptionIndex == 0,
                'A',
                () => context.read<StrollCubit>().selectOption(0),
              ),
            ),
            SizedBox(width: 12.w), // Increased spacing
            Expanded(
              child: _buildOptionCard(
                context,
                state.currentQuestion.options[1],
                1,
                state.selectedOptionIndex == 1,
                'B',
                () => context.read<StrollCubit>().selectOption(1),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h), // Increased spacing
        Row(
          children: [
            Expanded(
              child: _buildOptionCard(
                context,
                state.currentQuestion.options[2],
                2,
                state.selectedOptionIndex == 2,
                'C',
                () => context.read<StrollCubit>().selectOption(2),
              ),
            ),
            SizedBox(width: 12.w), // Increased spacing
            Expanded(
              child: _buildOptionCard(
                context,
                state.currentQuestion.options[3],
                3,
                state.selectedOptionIndex == 3,
                'D',
                () => context.read<StrollCubit>().selectOption(3),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOptionCard(BuildContext context, QuestionOption questionOption, int index, bool isSelected, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: 70.h, // Increased height for better touch targets
        padding: EdgeInsets.all(14.w), // Increased padding
        decoration: BoxDecoration(
          color: isSelected 
              ? Colors.blue.withValues(alpha: 0.4) 
              : Colors.black.withValues(alpha: 0.4), // More opacity for better visibility
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.white.withValues(alpha: 0.4),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 24.w, // Slightly larger
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 1.5),
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Text(
                  questionOption.text,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, StrollLoaded state) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pick your option.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'See who has a similar mind.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        SizedBox(width: 20.w),
        ActionButtons(
          isNextEnabled: context.read<StrollCubit>().isNextEnabled,
          isProcessing: state.isProcessing,
          onSkip: () => context.read<StrollCubit>().skipUser(),
          onMic: () => context.read<StrollCubit>().startVoiceMessage(),
          onNext: () => context.read<StrollCubit>().likeUser(),
        ),
      ],
    );
  }
}