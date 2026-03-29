import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/staff_notice_model.dart';

part 'staff_notice_event.dart';
part 'staff_notice_state.dart';

class StaffNoticeBloc extends Bloc<StaffNoticeEvent, StaffNoticeState> {
  StaffNoticeBloc() : super(StaffNoticeInitial()) {
    on<LoadStaffNotices>(_onLoadNotices);
  }

  Future<void> _onLoadNotices(
    LoadStaffNotices event,
    Emitter<StaffNoticeState> emit,
  ) async {
    emit(StaffNoticeLoading());
    try {
      // Mock API delay
      await Future.delayed(const Duration(milliseconds: 500));
      final notices = StaffNoticeModel.getMockNotices();
      emit(StaffNoticeLoaded(notices: notices));
    } catch (e) {
      emit(StaffNoticeError(message: e.toString()));
    }
  }
}
