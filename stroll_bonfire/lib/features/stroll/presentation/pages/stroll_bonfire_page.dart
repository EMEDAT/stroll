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
            alignment: Alignment(0.0, -1.8), // Push image way higher up
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            stops: const [0.0, 0.4, 0.7, 0.9, 1.0], // Added 0.9 for the transition
            colors: [
              Colors.transparent, // 0% - 40%: Completely transparent
              Colors.black.withValues(alpha: 0.5), // 40%: Light darkening starts
              Colors.black.withValues(alpha: 1), // 70%: Heavy darkening
              Colors.black.withValues(alpha: 1.0), // 90%: Complete black
              const Color(0xFF0F1115), // 90% - 100%: #0F1115 for bottom 10%
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
          flex: 65, // Reduced from 75 to give more space to bottom
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
          flex: 80, // Increased from 75 to give more space for larger icons
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
            child: SingleChildScrollView( // Add scrolling to prevent overflow
              child: Padding(
                padding: ResponsiveUtils.defaultScreenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileSection(state.currentUser, state.currentQuestion),
                    SizedBox(height: 10.h), // Further reduced spacing
                    _buildOptionsGrid(context, state),
                    SizedBox(height: 6.h), // Further reduced spacing
                    _buildBottomSection(context, state),
                    SizedBox(height: 6.h), // Further reduced spacing
                    const BottomNavigation(),
                    SizedBox(height: 12.h), // Extra space at bottom for larger icons
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection(User user, Question question) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w), // Added horizontal padding to entire profile section
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile image and name
          Padding(
            padding: EdgeInsets.only(top: 40.h), // Increased from 20.h to 40.h for more visible movement
            child: Stack(
              clipBehavior: Clip.none, // Allow overflow
              children: [
                // Name container (behind - first layer)
                Positioned(
                  left: 28.w, // Position to go behind image
                  top: 0,
                  child: Container(
                    width: 130.w,
                    padding: EdgeInsets.only(
                      left: 50.w,
                      right: 16.w,
                      top: 4.h, 
                      bottom: 4.h
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D0F11), // Background #0D0F11
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '${user.name}, ${user.age}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                // Profile image (in front - second layer)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileImage(user),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h), // Reduced from 30.h - less space for name background
                          SizedBox(height: 6.h), // Reduced from 8.h - smaller gap between name and question
                          Text(
                            question.text,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                              height: 1.3,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h), // Spacing before author answer
          // Author answer (centered on its own)
          Center(
            child: Text(
              '"${question.authorAnswer}"',
              style: TextStyle(
                fontSize: 12.sp, // 12px as requested
                fontWeight: FontWeight.w400, // 400 weight
                color: const Color(0xFFCBC9FF).withValues(alpha: 0.7), // #CBC9FFB2 text color
                fontStyle: FontStyle.italic, // Italic style
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildProfileImage(User user) {
  return Container(
    padding: EdgeInsets.all(8.w), // Padding around the profile image
    decoration: BoxDecoration(
      color: const Color(0xFF0D0F11), // Background color #0D0F11
      borderRadius: BorderRadius.circular(32.r), // Rounded corners
    ),
    child: Container(
      width: 50.w,
      height: 50.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
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
            SizedBox(width: 12.w),
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
        SizedBox(height: 12.h),
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
            SizedBox(width: 12.w),
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
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF232A2E), // Background color #232A2E
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF8B88EF) : Colors.transparent, // Border color #8B88EF
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row( // Changed from Column to Row for horizontal layout
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Letter circle on the LEFT
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xFF8B88EF) : Colors.transparent, // Fill with border color when selected
                border: Border.all(
                  color: isSelected ? const Color(0xFF8B88EF) : const Color(0xFFC4C4C4), // Blue border when selected
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFFC4C4C4), // White text when selected
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w), // Space between letter and text
            // Option text on the RIGHT
            Expanded(
              child: Text(
                questionOption.text,
                style: TextStyle(
                  color: const Color(0xFFC4C4C4), // Text color #C4C4C4
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Option 1: Reduce spacing between text and buttons
  Widget _buildBottomSection(BuildContext context, StrollLoaded state) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pick your option.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFFE5E5E5),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'See who has a similar mind.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFFE5E5E5),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10.w), // Reduced from 20.w to 10.w
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