part of 'add_exam_time_table_bloc.dart';

abstract class AddExamTimeTableEvent extends Equatable {
  const AddExamTimeTableEvent();

  @override
  List<Object?> get props => [];
}

class UpdateExamTimeTableClassEvent extends AddExamTimeTableEvent {
  final String selectedClass;
  const UpdateExamTimeTableClassEvent(this.selectedClass);

  @override
  List<Object?> get props => [selectedClass];
}

class UpdateExamTimeTableNameEvent extends AddExamTimeTableEvent {
  final String examName;
  const UpdateExamTimeTableNameEvent(this.examName);

  @override
  List<Object?> get props => [examName];
}

class UpdateExamTimeTablePdfUrlEvent extends AddExamTimeTableEvent {
  final String pdfUrl;
  const UpdateExamTimeTablePdfUrlEvent(this.pdfUrl);

  @override
  List<Object?> get props => [pdfUrl];
}

class SubmitExamTimeTableEvent extends AddExamTimeTableEvent {}

// --- STATE ---

class AddExamTimeTableState extends Equatable {
  final String? selectedClass;
  final String? examName;
  final String? pdfUrl;
  
  final bool isSubmitting;
  final bool submitSuccess;
  final String? error;

  const AddExamTimeTableState({
    this.selectedClass,
    this.examName,
    this.pdfUrl,
    this.isSubmitting = false,
    this.submitSuccess = false,
    this.error,
  });

  factory AddExamTimeTableState.initial() {
    return const AddExamTimeTableState();
  }

  AddExamTimeTableState copyWith({
    String? selectedClass,
    String? examName,
    String? pdfUrl,
    bool? isSubmitting,
    bool? submitSuccess,
    String? error,
  }) {
    return AddExamTimeTableState(
      selectedClass: selectedClass ?? this.selectedClass,
      examName: examName ?? this.examName,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitSuccess: submitSuccess ?? this.submitSuccess,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        selectedClass,
        examName,
        pdfUrl,
        isSubmitting,
        submitSuccess,
        error,
      ];
}
