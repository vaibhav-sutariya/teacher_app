part of 'pdf_bloc.dart';

abstract class PdfState extends Equatable {
  const PdfState();

  @override
  List<Object> get props => [];
}

class PdfLoading extends PdfState {}

class PdfLoaded extends PdfState {
  final String filePath;

  const PdfLoaded(this.filePath);

  @override
  List<Object> get props => [filePath];
}

class PdfError extends PdfState {
  final String message;

  const PdfError(this.message);

  @override
  List<Object> get props => [message];
}
