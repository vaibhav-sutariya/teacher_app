import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/pdf_repository.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  final PdfRepository repository;

  PdfBloc({required this.repository}) : super(PdfLoading()) {
    on<LoadPdf>(_onLoadPdf);
  }

  Future<void> _onLoadPdf(LoadPdf event, Emitter<PdfState> emit) async {
    emit(PdfLoading());

    final result = await repository.getPdf(url: event.pdfUrl);

    result.fold(
      (failure) => emit(PdfError(failure.message)),
      (filePath) => emit(PdfLoaded(filePath)),
    );
  }
}
