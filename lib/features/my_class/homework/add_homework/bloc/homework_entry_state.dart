import 'package:equatable/equatable.dart';

class HomeworkEntryState extends Equatable {
  final String content;
  final List<String> images;
  final List<String> documents;
  final bool isSubmitting;
  final bool isSuccess;
  final String? error;

  const HomeworkEntryState({
    this.content = '',
    this.images = const [],
    this.documents = const [],
    this.isSubmitting = false,
    this.isSuccess = false,
    this.error,
  });

  HomeworkEntryState copyWith({
    String? content,
    List<String>? images,
    List<String>? documents,
    bool? isSubmitting,
    bool? isSuccess,
    String? error,
  }) {
    return HomeworkEntryState(
      content: content ?? this.content,
      images: images ?? this.images,
      documents: documents ?? this.documents,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    content,
    images,
    documents,
    isSubmitting,
    isSuccess,
    error,
  ];
}
