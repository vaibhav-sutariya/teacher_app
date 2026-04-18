part of 'add_syllabus_bloc.dart';

abstract class AddSyllabusEvent extends Equatable {
  const AddSyllabusEvent();

  @override
  List<Object?> get props => [];
}

class UpdateSyllabusClassEvent extends AddSyllabusEvent {
  final String selectedClass;
  const UpdateSyllabusClassEvent(this.selectedClass);

  @override
  List<Object?> get props => [selectedClass];
}

class UpdateSyllabusSectionEvent extends AddSyllabusEvent {
  final String section;
  const UpdateSyllabusSectionEvent(this.section);

  @override
  List<Object?> get props => [section];
}

class UpdateSyllabusSubjectEvent extends AddSyllabusEvent {
  final String subject;
  const UpdateSyllabusSubjectEvent(this.subject);

  @override
  List<Object?> get props => [subject];
}

class UpdateSyllabusTypeEvent extends AddSyllabusEvent {
  final String type;
  const UpdateSyllabusTypeEvent(this.type);

  @override
  List<Object?> get props => [type];
}

class UpdateSyllabusPdfUrlEvent extends AddSyllabusEvent {
  final String pdfUrl;
  const UpdateSyllabusPdfUrlEvent(this.pdfUrl);

  @override
  List<Object?> get props => [pdfUrl];
}

class SubmitSyllabusEvent extends AddSyllabusEvent {}

// --- STATE ---

class AddSyllabusState extends Equatable {
  final String? selectedClass;
  final String? section;
  final String? subject;
  final String? type;
  final String? pdfUrl;
  
  final bool isSubmitting;
  final bool submitSuccess;
  final String? error;

  const AddSyllabusState({
    this.selectedClass,
    this.section,
    this.subject,
    this.type,
    this.pdfUrl,
    this.isSubmitting = false,
    this.submitSuccess = false,
    this.error,
  });

  factory AddSyllabusState.initial() {
    return const AddSyllabusState();
  }

  AddSyllabusState copyWith({
    String? selectedClass,
    String? section,
    String? subject,
    String? type,
    String? pdfUrl,
    bool? isSubmitting,
    bool? submitSuccess,
    String? error,
  }) {
    return AddSyllabusState(
      selectedClass: selectedClass ?? this.selectedClass,
      section: section ?? this.section,
      subject: subject ?? this.subject,
      type: type ?? this.type,
      pdfUrl: pdfUrl ?? this.pdfUrl,
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
        type,
        pdfUrl,
        isSubmitting,
        submitSuccess,
        error,
      ];
}
