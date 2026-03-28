part of 'parent_photo_list_bloc.dart';

enum ParentPhotoListStatus { initial, loading, loaded, error }

class ParentPhotoListState extends Equatable {
  final ParentPhotoListStatus status;
  final List<ParentListModel> parents;
  final List<ParentListModel> filteredParents;
  final String? className;
  final String? searchQuery;
  final String? errorMessage;

  const ParentPhotoListState({
    this.status = ParentPhotoListStatus.initial,
    this.parents = const [],
    this.filteredParents = const [],
    this.className,
    this.searchQuery,
    this.errorMessage,
  });

  ParentPhotoListState copyWith({
    ParentPhotoListStatus? status,
    List<ParentListModel>? parents,
    List<ParentListModel>? filteredParents,
    String? className,
    String? searchQuery,
    String? errorMessage,
  }) {
    return ParentPhotoListState(
      status: status ?? this.status,
      parents: parents ?? this.parents,
      filteredParents: filteredParents ?? this.filteredParents,
      className: className ?? this.className,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        parents,
        filteredParents,
        className,
        searchQuery,
        errorMessage,
      ];
}
