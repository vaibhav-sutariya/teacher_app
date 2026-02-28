import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../pdf_viewer/repositories/pdf_repository.dart';

part 'exam_time_table_event.dart';
part 'exam_time_table_state.dart';

class ExamTimeTableBloc extends Bloc<ExamTimeTableEvent, ExamTimeTableState> {
  final PdfRepository _repository;

  ExamTimeTableBloc({required PdfRepository repository})
    : _repository = repository,
      super(ExamTimeTableInitial()) {
    on<LoadExamTimeTable>(_onLoadExamTimeTable);
  }

  Future<void> _onLoadExamTimeTable(
    LoadExamTimeTable event,
    Emitter<ExamTimeTableState> emit,
  ) async {
    emit(ExamTimeTableLoading());
    // Simulated URL - reusing same sample PDF for now
    const pdfUrl =
        'https://www.aeee.in/wp-content/uploads/2020/08/Sample-pdf.pdf';

    final result = await _repository.getPdf(url: pdfUrl);

    result.fold(
      (failure) => emit(ExamTimeTableError(failure.message)),
      (filePath) => emit(ExamTimeTableLoaded(filePath)),
    );
  }
}
