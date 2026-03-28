import 'package:auto_route/auto_route.dart';
import '../../../../core/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../cubit/theme_cubit.dart';
import '../bloc/student_list_bloc.dart';
import '../widgets/student_info_card.dart';

@RoutePage()
class StudentListPage extends StatelessWidget implements AutoRouteWrapper {
  final String classId;
  final String className;

  const StudentListPage({
    super.key,
    required this.classId,
    required this.className,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StudentListBloc(repository: sl.get())
            ..add(LoadStudentsEvent(classId)),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      appBar: const AppAppBar(title: 'Details', showBackButton: true),
      body: Column(
        children: [
          _SearchField(),
          Expanded(child: _StudentListContent()),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.scale(16)),
      color: context.colors.surface,
      child: TextField(
        onChanged: (value) =>
            context.read<StudentListBloc>().add(FilterStudentsEvent(value)),
        decoration: InputDecoration(
          hintText: 'Search Student',
          prefixIcon: const Icon(Icons.search),
          fillColor: Colors.grey.withValues(alpha: 0.1),
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: context.scale(16)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.scale(12)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.scale(12)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _StudentListContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentListBloc, StudentListState>(
      buildWhen: (prev, curr) =>
          prev.filteredStudents != curr.filteredStudents ||
          prev.isLoading != curr.isLoading,
      builder: (context, state) {
        if (state.isLoading && state.allStudents.isEmpty) {
          return const Center(child: AppLoader());
        }

        if (state.filteredStudents.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: context.scale(64),
                  color: context.colors.textTertiary.withValues(alpha: 0.5),
                ),
                SizedBox(height: context.scaleHeight(16)),
                Text(
                  'No Results Found !',
                  style: TextStyle(
                    fontSize: context.scaleFont(16),
                    color: context.colors.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: state.filteredStudents.length,
          itemBuilder: (context, index) {
            return StudentInfoCard(
              student: state.filteredStudents[index],
              onTap: () {
                context.router.push(const StudentProfileRoute());
              },
            );
          },
        );
      },
    );
  }
}
