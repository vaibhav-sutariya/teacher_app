part of 'enquiry_bloc.dart';

abstract class EnquiryState extends Equatable {
  final DateTime selectedMonth;

  const EnquiryState({required this.selectedMonth});

  EnquiryState copyWith({DateTime? selectedMonth});

  @override
  List<Object?> get props => [selectedMonth];
}

class EnquiryInitial extends EnquiryState {
  const EnquiryInitial({required super.selectedMonth});

  @override
  EnquiryInitial copyWith({DateTime? selectedMonth}) {
    return EnquiryInitial(selectedMonth: selectedMonth ?? this.selectedMonth);
  }
}

class EnquiryLoading extends EnquiryState {
  const EnquiryLoading({required super.selectedMonth});

  @override
  EnquiryLoading copyWith({DateTime? selectedMonth}) {
    return EnquiryLoading(selectedMonth: selectedMonth ?? this.selectedMonth);
  }
}

class EnquiryLoaded extends EnquiryState {
  final List<EnquiryModel> enquiries;
  const EnquiryLoaded({required super.selectedMonth, required this.enquiries});

  @override
  EnquiryLoaded copyWith({DateTime? selectedMonth, List<EnquiryModel>? enquiries}) {
    return EnquiryLoaded(
      selectedMonth: selectedMonth ?? this.selectedMonth,
      enquiries: enquiries ?? this.enquiries,
    );
  }

  @override
  List<Object?> get props => [selectedMonth, enquiries];
}

class EnquiryError extends EnquiryState {
  final String message;
  const EnquiryError({required super.selectedMonth, required this.message});

  @override
  EnquiryError copyWith({DateTime? selectedMonth, String? message}) {
    return EnquiryError(
      selectedMonth: selectedMonth ?? this.selectedMonth,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [selectedMonth, message];
}
