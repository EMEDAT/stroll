import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Question Entity - Domain model for questions
class Question extends Equatable {
  final String id;
  final String text;
  final String authorAnswer;
  final List<QuestionOption> options;

  const Question({
    required this.id,
    required this.text,
    required this.authorAnswer,
    required this.options,
  });

  Question copyWith({
    String? id,
    String? text,
    String? authorAnswer,
    List<QuestionOption>? options,
  }) {
    return Question(
      id: id ?? this.id,
      text: text ?? this.text,
      authorAnswer: authorAnswer ?? this.authorAnswer,
      options: options ?? this.options,
    );
  }

  @override
  List<Object?> get props => [id, text, authorAnswer, options];

  @override
  String toString() {
    return 'Question(id: $id, text: $text, authorAnswer: $authorAnswer, options: $options)';
  }
}

/// Question Option Entity - Domain model for question options
class QuestionOption extends Equatable {
  final String id;
  final String text;
  final IconData icon;
  final Color backgroundColor;

  const QuestionOption({
    required this.id,
    required this.text,
    required this.icon,
    required this.backgroundColor,
  });

  QuestionOption copyWith({
    String? id,
    String? text,
    IconData? icon,
    Color? backgroundColor,
  }) {
    return QuestionOption(
      id: id ?? this.id,
      text: text ?? this.text,
      icon: icon ?? this.icon,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  List<Object?> get props => [id, text, icon, backgroundColor];

  @override
  String toString() {
    return 'QuestionOption(id: $id, text: $text, icon: $icon, backgroundColor: $backgroundColor)';
  }
}