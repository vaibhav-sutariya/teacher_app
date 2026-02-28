import 'package:equatable/equatable.dart';
import '../models/add_concern_request_model.dart';

abstract class AddConcernEvent extends Equatable {
  const AddConcernEvent();

  @override
  List<Object?> get props => [];
}

class SubmitConcern extends AddConcernEvent {
  final AddConcernRequestModel request;

  const SubmitConcern(this.request);

  @override
  List<Object?> get props => [request];
}

class FileSelected extends AddConcernEvent {
  final String path;

  const FileSelected(this.path);

  @override
  List<Object?> get props => [path];
}
