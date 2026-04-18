part of 'enquiry_bloc.dart';

abstract class EnquiryEvent extends Equatable {
  const EnquiryEvent();

  @override
  List<Object?> get props => [];
}

class LoadEnquiries extends EnquiryEvent {}

class ChangeEnquiryMonth extends EnquiryEvent {
  final DateTime newMonth;
  const ChangeEnquiryMonth(this.newMonth);

  @override
  List<Object?> get props => [newMonth];
}
