import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../pdf_viewer/repositories/pdf_repository.dart';

part 'time_table_event.dart';
part 'time_table_state.dart';

class TimeTableBloc extends Bloc<TimeTableEvent, TimeTableState> {
  final PdfRepository _repository;

  TimeTableBloc({required PdfRepository repository})
    : _repository = repository,
      super(TimeTableInitial()) {
    on<LoadTimeTable>(_onLoadTimeTable);
  }

  Future<void> _onLoadTimeTable(
    LoadTimeTable event,
    Emitter<TimeTableState> emit,
  ) async {
    emit(TimeTableLoading());
    // Simulated URL - in real app this comes from an API
    const pdfUrl =
        'https://www.aeee.in/wp-content/uploads/2020/08/Sample-pdf.pdf';

    final result = await _repository.getPdf(url: pdfUrl);

    result.fold(
      (failure) => emit(TimeTableError(failure.message)),
      (filePath) => emit(TimeTableLoaded(filePath)),
    );
  }
}
