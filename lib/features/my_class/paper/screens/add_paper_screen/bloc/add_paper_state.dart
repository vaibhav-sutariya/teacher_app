part of 'add_paper_bloc.dart';

abstract class AddPaperEvent extends Equatable {
  const AddPaperEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePaperClassEvent extends AddPaperEvent {
  final String selectedClass;
  const UpdatePaperClassEvent(this.selectedClass);

  @override
  List<Object?> get props => [selectedClass];
}

class UpdatePaperSectionEvent extends AddPaperEvent {
  final String section;
  const UpdatePaperSectionEvent(this.section);

  @override
  List<Object?> get props => [section];
}

class UpdatePaperSubjectEvent extends AddPaperEvent {
  final String subject;
  const UpdatePaperSubjectEvent(this.subject);

  @override
  List<Object?> get props => [subject];
}

class UpdatePaperNameEvent extends AddPaperEvent {
  final String paperName;
  const UpdatePaperNameEvent(this.paperName);

  @override
  List<Object?> get props => [paperName];
}

class UpdatePaperPdfUrlEvent extends AddPaperEvent {
  final String pdfUrl;
  const UpdatePaperPdfUrlEvent(this.pdfUrl);

  @override
  List<Object?> get props => [pdfUrl];
}

class SubmitPaperEvent extends AddPaperEvent {}

// --- STATE ---

class AddPaperState extends Equatable {
  final String? selectedClass;
  final String? section;
  final String? subject;
  final String? paperName;
  final String? pdfUrl;
  
  final bool isSubmitting;
  final bool submitSuccess;
  final String? error;

  const AddPaperState({
    this.selectedClass,
    this.section,
    this.subject,
    this.paperName,
    this.pdfUrl,
    this.isSubmitting = false,
    this.submitSuccess = false,
    this.error,
  });

  factory AddPaperState.initial() {
    return const AddPaperState();
  }

  AddPaperState copyWith({
    String? selectedClass,
    String? section,
    String? subject,
    String? paperName,
    String? pdfUrl,
    bool? isSubmitting,
    bool? submitSuccess,
    String? error,
  }) {
    return AddPaperState(
      selectedClass: selectedClass ?? this.selectedClass,
      section: section ?? this.section,
      subject: subject ?? this.subject,
      paperName: paperName ?? this.paperName,
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
        paperName,
        pdfUrl,
        isSubmitting,
        submitSuccess,
        error,
      ];
}
