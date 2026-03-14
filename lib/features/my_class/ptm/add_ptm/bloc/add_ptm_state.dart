import 'package:equatable/equatable.dart';

class AddPtmState extends Equatable {
  final String title;
  final DateTime? date;
  final String time;
  final String location;
  final String description;
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  const AddPtmState({
    this.title = '',
    this.date,
    this.time = '',
    this.location = '',
    this.description = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  bool get isFormValid =>
      title.isNotEmpty &&
      date != null &&
      time.isNotEmpty &&
      location.isNotEmpty &&
      description.isNotEmpty;

  AddPtmState copyWith({
    String? title,
    DateTime? date,
    String? time,
    String? location,
    String? description,
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return AddPtmState(
      title: title ?? this.title,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      description: description ?? this.description,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    title,
    date,
    time,
    location,
    description,
    isLoading,
    isSuccess,
    error,
  ];
}
