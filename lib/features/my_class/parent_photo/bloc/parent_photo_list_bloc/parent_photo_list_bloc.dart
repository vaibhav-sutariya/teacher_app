import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/parent_list_model.dart';

part 'parent_photo_list_event.dart';
part 'parent_photo_list_state.dart';

class ParentPhotoListBloc extends Bloc<ParentPhotoListEvent, ParentPhotoListState> {
  ParentPhotoListBloc() : super(const ParentPhotoListState()) {
    on<LoadParents>(_onLoadParents);
    on<SearchParents>(_onSearchParents);
    on<UpdateParentPhoto>(_onUpdateParentPhoto);
  }

  void _onLoadParents(LoadParents event, Emitter<ParentPhotoListState> emit) async {
    emit(state.copyWith(status: ParentPhotoListStatus.loading, className: event.className));
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      final mockParents = [
        ParentListModel(
          id: '1',
          parentName: 'MR. AYALDASANI',
          studentName: 'AYALDASANI NISHKA KAPIL',
          className: event.className,
          rollNo: '1',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        ParentListModel(
          id: '2',
          parentName: 'MRS. DESAI',
          studentName: 'DESAI SHELVI AJAY',
          className: event.className,
          rollNo: '2',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        ParentListModel(
          id: '3',
          parentName: 'MR. GOL',
          studentName: 'GOL YANA CHIRAGKUMAR',
          className: event.className,
          rollNo: '3',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        ParentListModel(
          id: '4',
          parentName: 'MR. GOSAI',
          studentName: 'GOSAI MISTY JATINGIRI',
          className: event.className,
          rollNo: '4',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        ParentListModel(
          id: '5',
          parentName: 'MR. JANGADE',
          studentName: 'JANGADE HAZEL KALPEN',
          className: event.className,
          rollNo: '5',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        ParentListModel(
          id: '6',
          parentName: 'MRS. KRIPLANI',
          studentName: 'KRIPLANI KHANISHKA KUNAL',
          className: event.className,
          rollNo: '6',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        ParentListModel(
          id: '7',
          parentName: 'MR. LUNAGARIA',
          studentName: 'LUNAGARIA MISHVA KISHAN',
          className: event.className,
          rollNo: '7',
          isUploaded: true,
          photoUrl: 'https://via.placeholder.com/150',
        ),
        ParentListModel(
          id: '8',
          parentName: 'MRS. MAHETA',
          studentName: 'MAHETA KAVYA ARJUN',
          className: event.className,
          rollNo: '8',
          isUploaded: false,
          photoUrl: 'https://via.placeholder.com/150',
        ),
      ];

      emit(state.copyWith(
        status: ParentPhotoListStatus.loaded,
        parents: mockParents,
        filteredParents: mockParents,
      ));
    } catch (e) {
      emit(state.copyWith(status: ParentPhotoListStatus.error, errorMessage: e.toString()));
    }
  }

  void _onSearchParents(SearchParents event, Emitter<ParentPhotoListState> emit) {
    final query = event.query.toLowerCase();
    final filtered = state.parents.where((p) {
      return p.parentName.toLowerCase().contains(query) || 
             p.studentName.toLowerCase().contains(query) || 
             p.rollNo.contains(query);
    }).toList();

    emit(state.copyWith(
      searchQuery: event.query,
      filteredParents: filtered,
    ));
  }

  void _onUpdateParentPhoto(UpdateParentPhoto event, Emitter<ParentPhotoListState> emit) {
    final updatedParents = state.parents.map((p) {
      if (p.id == event.parentId) {
        return ParentListModel(
          id: p.id,
          parentName: p.parentName,
          studentName: p.studentName,
          className: p.className,
          rollNo: p.rollNo,
          isUploaded: true,
          photoUrl: p.photoUrl,
        );
      }
      return p;
    }).toList();

    final filtered = updatedParents.where((p) {
      final query = state.searchQuery?.toLowerCase() ?? '';
      return p.parentName.toLowerCase().contains(query) || 
             p.studentName.toLowerCase().contains(query) || 
             p.rollNo.contains(query);
    }).toList();

    emit(state.copyWith(
      parents: updatedParents,
      filteredParents: filtered,
    ));
  }
}
