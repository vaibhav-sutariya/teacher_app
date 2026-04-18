import 'package:equatable/equatable.dart';

class ClassworkEntryState extends Equatable {
  final String content;
  final bool isSubmitting;
  final bool isSuccess;
  final String? error;

  const ClassworkEntryState({
    this.content = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.error,
  });

  @override
  List<Object?> get props => [content, isSubmitting, isSuccess, error];

  ClassworkEntryState copyWith({
    String? content,
    bool? isSubmitting,
    bool? isSuccess,
    String? error,
  }) {
    return ClassworkEntryState(
      content: content ?? this.content,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }
}
