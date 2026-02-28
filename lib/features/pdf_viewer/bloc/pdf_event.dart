part of 'pdf_bloc.dart';

abstract class PdfEvent extends Equatable {
  const PdfEvent();

  @override
  List<Object> get props => [];
}

class LoadPdf extends PdfEvent {
  final String pdfUrl;

  const LoadPdf(this.pdfUrl);

  @override
  List<Object> get props => [pdfUrl];
}
