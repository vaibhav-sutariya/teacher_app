import 'package:equatable/equatable.dart';

enum AddConcernStatus { initial, loading, success, failure }

class AddConcernState extends Equatable {
  final AddConcernStatus status;
  final String? attachmentPath;
  final String? message;

  const AddConcernState({
    this.status = AddConcernStatus.initial,
    this.attachmentPath,
    this.message,
  });

  AddConcernState copyWith({
    AddConcernStatus? status,
    String? attachmentPath,
    String? message,
  }) {
    return AddConcernState(
      status: status ?? this.status,
      attachmentPath: attachmentPath ?? this.attachmentPath,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, attachmentPath, message];
}
