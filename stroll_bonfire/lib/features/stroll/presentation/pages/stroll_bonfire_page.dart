import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../cubit/stroll_cubit.dart';
import '../cubit/stroll_state.dart';
import '../widgets/stroll_header.dart';
import '../widgets/profile_card.dart';
import '../widgets/action_buttons.dart';
import '../widgets/bottom_navigation.dart';
import '../../domain/entities/question.dart';

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
              stops: const [0.0, 0.6, 1.0],
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.3),
                Colors.black.withValues(alpha: 0.8),
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
    return Padding(
      padding: ResponsiveUtils.defaultScreenPadding,
      child: Column(
        children: [
          SizedBox(height: 16.h),
          const StrollHeader(),
          SizedBox(height: 40.h),
          ProfileCard(
            user: state.currentUser,
            question: state.currentQuestion,
          ),
          SizedBox(height: 40.h),
          // Just the options grid without text
          _buildOptionsGrid(context, state),
          const Spacer(),
          // Text and action buttons together at bottom
          _buildBottomSection(context, state),
          SizedBox(height: 30.h),
          const BottomNavigation(),
          SizedBox(height: 20.h),
        ],
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
        height: 100.h, // Fixed height to prevent flex issues
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
          mainAxisSize: MainAxisSize.min, // Prevent flex issues
          children: [
            Row(
              children: [
                Container(
                  width: 24.w,
                  height: 24.w,
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
              ],
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: Text(
                questionOption.text,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
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