import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../cubit/stroll_cubit.dart';
import '../cubit/stroll_state.dart';
import '../widgets/stroll_header.dart';
import '../widgets/profile_card.dart';
import '../widgets/options_section.dart';
import '../widgets/action_buttons.dart';
import '../widgets/bottom_navigation.dart';

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
              colors: [
                Colors.black.withValues(alpha: 0.2),
                Colors.black.withValues(alpha: 0.6),
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
          OptionsSection(
            options: state.currentQuestion.options,
            selectedIndex: state.selectedOptionIndex,
            onOptionSelected: (index) {
              context.read<StrollCubit>().selectOption(index);
            },
          ),
          const Spacer(),
          ActionButtons(
            isNextEnabled: context.read<StrollCubit>().isNextEnabled,
            isProcessing: state.isProcessing,
            onSkip: () => context.read<StrollCubit>().skipUser(),
            onMic: () => context.read<StrollCubit>().startVoiceMessage(),
            onNext: () => context.read<StrollCubit>().likeUser(),
          ),
          SizedBox(height: 30.h),
          const BottomNavigation(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}