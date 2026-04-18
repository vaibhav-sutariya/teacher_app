import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../../../student_photo_upload/screens/student_photo_upload/ui/widgets/photo_upload_bottom_sheet.dart';
import '../bloc/parent_photo_list_bloc/parent_photo_list_bloc.dart';
import 'widgets/parent_photo_item.dart';

@RoutePage()
class ParentPhotoListPage extends StatelessWidget {
  final String className;

  const ParentPhotoListPage({super.key, required this.className});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParentPhotoListBloc()..add(LoadParents(className)),
      child: _ParentPhotoListPageContent(className: className),
    );
  }
}

class _ParentPhotoListPageContent extends StatelessWidget {
  final String className;

  const _ParentPhotoListPageContent({required this.className});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(
        title: 'Parent List',
        actions: [
          Padding(
            padding: EdgeInsets.only(right: context.scale(16)),
            child: Row(
              children: [
                Text(
                  'All',
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: context.scale(20),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(context.scale(16)),
            child: TextField(
              onChanged: (value) {
                context.read<ParentPhotoListBloc>().add(SearchParents(value));
              },
              decoration: InputDecoration(
                hintText: 'Search Parent or Student',
                prefixIcon: Icon(
                  Icons.search,
                  color: context.colors.textSecondary,
                ),
                filled: true,
                fillColor: Colors.grey.withValues(alpha: 0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.scale(12)),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: context.scaleHeight(10),
                ),
              ),
            ),
          ),
          // Parent List
          Expanded(
            child: BlocBuilder<ParentPhotoListBloc, ParentPhotoListState>(
              builder: (context, state) {
                if (state.status == ParentPhotoListStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.status == ParentPhotoListStatus.error) {
                  return Center(
                    child: Text(state.errorMessage ?? 'Error Loading Parents'),
                  );
                }

                if (state.filteredParents.isEmpty) {
                  return Center(
                    child: Text(
                      'No record found',
                      style: TextStyle(color: context.colors.textSecondary),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: state.filteredParents.length,
                  itemBuilder: (context, index) {
                    final parent = state.filteredParents[index];
                    return ParentPhotoItem(
                      parent: parent,
                      onTap: () {
                        showPhotoUploadBottomSheet(
                          context: context,
                          title: parent.parentName, // Use parent name as title
                          photoUrl: parent.photoUrl,
                          onCamera: () {
                            // Simulate upload
                            context.read<ParentPhotoListBloc>().add(
                              UpdateParentPhoto(
                                parentId: parent.id,
                                status: 'uploaded',
                              ),
                            );
                          },
                          onGallery: () {
                            // Simulate upload
                            context.read<ParentPhotoListBloc>().add(
                              UpdateParentPhoto(
                                parentId: parent.id,
                                status: 'uploaded',
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          // Summary Footer
          Container(
            padding: EdgeInsets.symmetric(vertical: context.scaleHeight(12)),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Text(
              'SUMMARY',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.scaleFont(14),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
