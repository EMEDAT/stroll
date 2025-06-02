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
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.3, 1.0],
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.6),
                Colors.black.withValues(alpha: 1.0), // Complete black coverage
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
          flex: 45, // Reduced from 60% to 45%
          child: Padding(
            padding: ResponsiveUtils.defaultScreenPadding,
            child: Column(
              children: [
                SizedBox(height: 16.h),
                const StrollHeader(),
                const Spacer(),
              ],
            ),
          ),
        ),
        // Bottom section with content - MOVED UP!
        Expanded(
          flex: 55, // Increased from 40% to 55%
          child: Padding(
            padding: ResponsiveUtils.defaultScreenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileSection(state.currentUser, state.currentQuestion),
                SizedBox(height: 16.h), // Reduced spacing
                _buildOptionsGrid(context, state),
                SizedBox(height: 12.h), // Add small gap before bottom section
                _buildBottomSection(context, state),
                SizedBox(height: 16.h), // Reduced spacing
                const BottomNavigation(),
                SizedBox(height: 16.h), // Reduced bottom padding
              ],
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
            SizedBox(width: 12.w), // Reduced spacing
            Text(
              '${user.name}, ${user.age}',
              style: TextStyle(
                fontSize: 11.sp, // Reduced from 24
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h), // Reduced from 20
        // Question text
        Text(
          question.text,
          style: TextStyle(
            fontSize: 20.sp, // Reduced from 32
            fontWeight: FontWeight.w700,
            color: AppColors.white,
            height: 1.1, // Tighter line height
          ),
        ),
        SizedBox(height: 8.h), // Reduced from 12
        // Author answer
        Text(
          '"${question.authorAnswer}"',
          style: TextStyle(
            fontSize: 12.sp, // Reduced from 16
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
          width: 40.w, // Reduced from 60
          height: 40.w, // Reduced from 60
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: user.isOnline ? AppColors.onlineGreen : AppColors.white40,
              width: 2, // Reduced from 3
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
                    size: 24.sp, // Reduced from 32
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
              width: 10.w, // Reduced from 12
              height: 10.w, // Reduced from 12
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
            SizedBox(width: 8.w), // Reduced spacing
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
        SizedBox(height: 8.h), // Reduced spacing
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
            SizedBox(width: 8.w), // Reduced spacing
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
        height: 60.h, // Reduced from 100
        padding: EdgeInsets.all(12.w), // Reduced padding
        decoration: BoxDecoration(
          color: isSelected 
              ? Colors.blue.withValues(alpha: 0.3) 
              : Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12.r), // Smaller radius
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.white.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20.w, // Reduced from 24
              height: 20.w, // Reduced from 24
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 1.5), // Thinner border
              ),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14.sp, // Reduced from 12
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h), // Reduced spacing
            Expanded(
              child: Text(
                questionOption.text,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14.sp, // Reduced from 14
                  fontWeight: FontWeight.w400,
                  height: 1.2, // Tighter line height
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