import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/question.dart';
import 'stroll_state.dart';

/// Stroll Cubit - Business logic for the Stroll feature
class StrollCubit extends Cubit<StrollState> {
  StrollCubit() : super(const StrollInitial());

  /// Initialize the stroll with mock data
  Future<void> initialize() async {
    try {
      emit(const StrollLoading());

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock user data
      const user = User(
        id: '1',
        name: 'Angelko',
        age: 28,
        profileImageUrl: 'assets/images/profileImage.jpg',
        isOnline: true,
      );

      // Mock question data with options
      const question = Question(
        id: '1',
        text: 'What is your favorite time of the day?',
        authorAnswer: 'Mine is definitely the peace in the morning.',
        options: [
          QuestionOption(
            id: '1',
            text: 'The peace in the\nearly mornings',
            icon: Icons.wb_sunny_outlined,
            backgroundColor: AppColors.morningBg,
          ),
          QuestionOption(
            id: '2',
            text: 'The magical\ngolden hours',
            icon: Icons.wb_twilight_outlined,
            backgroundColor: AppColors.goldenBg,
          ),
          QuestionOption(
            id: '3',
            text: 'Wind down time\nafter dinners',
            icon: Icons.restaurant_outlined,
            backgroundColor: AppColors.dinnerBg,
          ),
          QuestionOption(
            id: '4',
            text: 'The serenity past\nmidnight',
            icon: Icons.nightlight_round_outlined,
            backgroundColor: AppColors.midnightBg,
          ),
        ],
      );

      emit(const StrollLoaded(
        currentUser: user,
        currentQuestion: question,
      ));
    } catch (e) {
      emit(StrollError(message: 'Failed to initialize: ${e.toString()}'));
    }
  }

  /// Select an option
  void selectOption(int index) {
    if (state is StrollLoaded) {
      final currentState = state as StrollLoaded;
      if (index >= 0 && index < currentState.currentQuestion.options.length) {
        emit(currentState.copyWith(selectedOptionIndex: index));
      }
    }
  }

  /// Skip the current user
  void skipUser() {
    if (state is StrollLoaded) {
      final currentState = state as StrollLoaded;
      emit(currentState.copyWith(selectedOptionIndex: -1));
      // Here you would typically navigate to the next user
    }
  }

  /// Like the current user (proceed with selected option)
  void likeUser() {
    if (state is StrollLoaded) {
      final currentState = state as StrollLoaded;
      if (currentState.selectedOptionIndex != -1) {
        emit(currentState.copyWith(isProcessing: true));
        // Here you would typically send the match request
        // For now, just reset
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (state is StrollLoaded) {
            final loadedState = state as StrollLoaded;
            emit(loadedState.copyWith(
              selectedOptionIndex: -1,
              isProcessing: false,
            ));
          }
        });
      }
    }
  }

  /// Start voice message recording
  void startVoiceMessage() {
    // Handle voice message functionality
    debugPrint('Voice message started');
  }

  /// Check if next action is enabled
  bool get isNextEnabled {
    if (state is StrollLoaded) {
      final currentState = state as StrollLoaded;
      return currentState.selectedOptionIndex != -1 && !currentState.isProcessing;
    }
    return false;
  }
}