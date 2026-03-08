import 'package:equatable/equatable.dart';

class SubjectWiseHomeworkEntryState extends Equatable {
  final String content;
  final DateTime? submissionDate;
  final List<String> images;
  final List<String> documents;
  final bool isSubmitting;
  final bool isSuccess;
  final String? error;

  const SubjectWiseHomeworkEntryState({
    this.content = '',
    this.submissionDate,
    this.images = const [],
    this.documents = const [],
    this.isSubmitting = false,
    this.isSuccess = false,
    this.error,
  });

  SubjectWiseHomeworkEntryState copyWith({
    String? content,
    DateTime? submissionDate,
    List<String>? images,
    List<String>? documents,
    bool? isSubmitting,
    bool? isSuccess,
    String? error,
  }) {
    return SubjectWiseHomeworkEntryState(
      content: content ?? this.content,
      submissionDate: submissionDate ?? this.submissionDate,
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
    submissionDate,
    images,
    documents,
    isSubmitting,
    isSuccess,
    error,
  ];
}
