import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/question.dart';

/// Stroll State - All possible states for the Stroll feature
abstract class StrollState extends Equatable {
  const StrollState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the app starts
class StrollInitial extends StrollState {
  const StrollInitial();
}

/// Loading state when fetching data
class StrollLoading extends StrollState {
  const StrollLoading();
}

/// Loaded state with user and question data
class StrollLoaded extends StrollState {
  final User currentUser;
  final Question currentQuestion;
  final int selectedOptionIndex;
  final bool isProcessing;

  const StrollLoaded({
    required this.currentUser,
    required this.currentQuestion,
    this.selectedOptionIndex = -1,
    this.isProcessing = false,
  });

  StrollLoaded copyWith({
    User? currentUser,
    Question? currentQuestion,
    int? selectedOptionIndex,
    bool? isProcessing,
  }) {
    return StrollLoaded(
      currentUser: currentUser ?? this.currentUser,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      selectedOptionIndex: selectedOptionIndex ?? this.selectedOptionIndex,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }

  @override
  List<Object?> get props => [
        currentUser,
        currentQuestion,
        selectedOptionIndex,
        isProcessing,
      ];

  @override
  String toString() {
    return 'StrollLoaded(currentUser: $currentUser, currentQuestion: $currentQuestion, selectedOptionIndex: $selectedOptionIndex, isProcessing: $isProcessing)';
  }
}

/// Error state when something goes wrong
class StrollError extends StrollState {
  final String message;

  const StrollError({required this.message});

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'StrollError(message: $message)';
}