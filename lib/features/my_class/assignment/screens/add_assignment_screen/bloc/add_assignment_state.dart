part of 'add_assignment_bloc.dart';

class AddAssignmentState extends Equatable {
  final String? selectedClass;
  final String? section;
  final String? subject;
  final String? lesson;
  final String? topic;
  final AttachmentType attachmentType;
  final String description;
  final bool isSmsEnabled;
  
  final bool isSubmitting;
  final bool submitSuccess;
  final String? error;

  const AddAssignmentState({
    this.selectedClass,
    this.section,
    this.subject,
    this.lesson,
    this.topic,
    this.attachmentType = AttachmentType.image,
    this.description = '',
    this.isSmsEnabled = false,
    this.isSubmitting = false,
    this.submitSuccess = false,
    this.error,
  });

  factory AddAssignmentState.initial() {
    return const AddAssignmentState();
  }

  AddAssignmentState copyWith({
    String? selectedClass,
    String? section,
    String? subject,
    String? lesson,
    String? topic,
    AttachmentType? attachmentType,
    String? description,
    bool? isSmsEnabled,
    bool? isSubmitting,
    bool? submitSuccess,
    String? error,
  }) {
    return AddAssignmentState(
      selectedClass: selectedClass ?? this.selectedClass,
      section: section ?? this.section,
      subject: subject ?? this.subject,
      lesson: lesson ?? this.lesson,
      topic: topic ?? this.topic,
      attachmentType: attachmentType ?? this.attachmentType,
      description: description ?? this.description,
      isSmsEnabled: isSmsEnabled ?? this.isSmsEnabled,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitSuccess: submitSuccess ?? this.submitSuccess,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        selectedClass,
        section,
        subject,
        lesson,
        topic,
        attachmentType,
        description,
        isSmsEnabled,
        isSubmitting,
        submitSuccess,
        error,
      ];
}
