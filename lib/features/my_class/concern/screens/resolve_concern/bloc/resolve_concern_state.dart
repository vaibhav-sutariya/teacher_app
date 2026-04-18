import 'package:equatable/equatable.dart';
import '../../../models/concern_model.dart';
import 'package:image_picker/image_picker.dart';

class ResolveConcernState extends Equatable {
  final ConcernStatus status;
  final String comment;
  final List<XFile> proofImages;
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  const ResolveConcernState({
    this.status = ConcernStatus.inProcess,
    this.comment = '',
    this.proofImages = const [],
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  bool get isFormValid =>
      comment.trim().isNotEmpty && status != ConcernStatus.open;

  ResolveConcernState copyWith({
    ConcernStatus? status,
    String? comment,
    List<XFile>? proofImages,
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return ResolveConcernState(
      status: status ?? this.status,
      comment: comment ?? this.comment,
      proofImages: proofImages ?? this.proofImages,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    comment,
    proofImages,
    isLoading,
    isSuccess,
    error,
  ];
}
