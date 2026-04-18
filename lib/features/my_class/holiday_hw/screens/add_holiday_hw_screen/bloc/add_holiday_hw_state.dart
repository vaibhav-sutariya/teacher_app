part of 'add_holiday_hw_bloc.dart';

abstract class AddHolidayHwEvent extends Equatable {
  const AddHolidayHwEvent();

  @override
  List<Object?> get props => [];
}

class UpdateHolidayHwClassEvent extends AddHolidayHwEvent {
  final String selectedClass;
  const UpdateHolidayHwClassEvent(this.selectedClass);

  @override
  List<Object?> get props => [selectedClass];
}

class UpdateHolidayHwSectionEvent extends AddHolidayHwEvent {
  final String section;
  const UpdateHolidayHwSectionEvent(this.section);

  @override
  List<Object?> get props => [section];
}

class UpdateHolidayHwSubjectEvent extends AddHolidayHwEvent {
  final String subject;
  const UpdateHolidayHwSubjectEvent(this.subject);

  @override
  List<Object?> get props => [subject];
}

class UpdateHolidayHwNameEvent extends AddHolidayHwEvent {
  final String hwName;
  const UpdateHolidayHwNameEvent(this.hwName);

  @override
  List<Object?> get props => [hwName];
}

class UpdateHolidayHwPdfUrlEvent extends AddHolidayHwEvent {
  final String pdfUrl;
  const UpdateHolidayHwPdfUrlEvent(this.pdfUrl);

  @override
  List<Object?> get props => [pdfUrl];
}

class SubmitHolidayHwEvent extends AddHolidayHwEvent {}

// --- STATE ---

class AddHolidayHwState extends Equatable {
  final String? selectedClass;
  final String? section;
  final String? subject;
  final String? hwName;
  final String? pdfUrl;
  
  final bool isSubmitting;
  final bool submitSuccess;
  final String? error;

  const AddHolidayHwState({
    this.selectedClass,
    this.section,
    this.subject,
    this.hwName,
    this.pdfUrl,
    this.isSubmitting = false,
    this.submitSuccess = false,
    this.error,
  });

  factory AddHolidayHwState.initial() {
    return const AddHolidayHwState();
  }

  AddHolidayHwState copyWith({
    String? selectedClass,
    String? section,
    String? subject,
    String? hwName,
    String? pdfUrl,
    bool? isSubmitting,
    bool? submitSuccess,
    String? error,
  }) {
    return AddHolidayHwState(
      selectedClass: selectedClass ?? this.selectedClass,
      section: section ?? this.section,
      subject: subject ?? this.subject,
      hwName: hwName ?? this.hwName,
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
        hwName,
        pdfUrl,
        isSubmitting,
        submitSuccess,
        error,
      ];
}
