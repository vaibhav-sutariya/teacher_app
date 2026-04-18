import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_staff_notice_event.dart';
part 'add_staff_notice_state.dart';

class AddStaffNoticeBloc extends Bloc<AddStaffNoticeEvent, AddStaffNoticeState> {
  AddStaffNoticeBloc() : super(AddStaffNoticeState()) {
    on<UpdateStaffNoticeTitle>(_onUpdateTitle);
    on<UpdateStaffNoticeContent>(_onUpdateContent);
    on<UpdateStaffNoticeDate>(_onUpdateDate);
    on<SubmitStaffNotice>(_onSubmit);
  }

  void _onUpdateTitle(UpdateStaffNoticeTitle event, Emitter<AddStaffNoticeState> emit) {
    emit(state.copyWith(title: event.title, error: null));
  }

  void _onUpdateContent(UpdateStaffNoticeContent event, Emitter<AddStaffNoticeState> emit) {
    emit(state.copyWith(content: event.content, error: null));
  }

  void _onUpdateDate(UpdateStaffNoticeDate event, Emitter<AddStaffNoticeState> emit) {
    emit(state.copyWith(date: event.date, error: null));
  }

  Future<void> _onSubmit(SubmitStaffNotice event, Emitter<AddStaffNoticeState> emit) async {
    if (state.title.isEmpty || state.content.isEmpty) {
      emit(state.copyWith(error: 'Please fill all required fields'));
      return;
    }

    emit(state.copyWith(status: AddStaffNoticeStatus.submitting));
    try {
      // Mock API call
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: AddStaffNoticeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AddStaffNoticeStatus.error, error: e.toString()));
    }
  }
}
