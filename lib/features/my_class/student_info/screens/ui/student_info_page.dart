import 'package:auto_route/auto_route.dart';
import '../../../../../core/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../core/widgets/app_loader.dart';
import '../../../../../cubit/theme_cubit.dart';
import '../bloc/student_info_bloc.dart';
import '../../models/student_model.dart';
import 'widgets/class_info_card.dart';
import 'widgets/student_info_card.dart';

@RoutePage()
class StudentInfoPage extends StatelessWidget implements AutoRouteWrapper {
  const StudentInfoPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StudentInfoBloc(repository: sl.get())..add(LoadClassesEvent()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: AppBar(
          backgroundColor: context.colors.primary,
          elevation: 0,
          title: Text(
            'Student Info',
            style: TextStyle(
              color: Colors.white,
              fontSize: context.scaleFont(18),
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => context.router.back(),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(context.scaleHeight(48)),
            child: Container(
              color: context.colors.primary,
              child: TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
                labelStyle: TextStyle(
                  fontSize: context.scaleFont(14),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
                tabs: const [
                  Tab(text: 'CLASS'),
                  Tab(text: 'NAME'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(children: [_ClassTabContent(), _NameTabContent()]),
      ),
    );
  }
}

class _ClassTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentInfoBloc, StudentInfoState>(
      buildWhen: (prev, curr) =>
          prev.classes != curr.classes || prev.isLoading != curr.isLoading,
      builder: (context, state) {
        if (state.isLoading && state.classes.isEmpty) {
          return const Center(child: AppLoader());
        }

        if (state.classes.isEmpty) {
          return const Center(child: Text('No Classes Found'));
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: state.classes.length,
          itemBuilder: (context, index) {
            return ClassInfoCard(classInfo: state.classes[index]);
          },
        );
      },
    );
  }
}

class _NameTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SearchField(),
        Expanded(child: _StudentListContent()),
      ],
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
            context.read<StudentInfoBloc>().add(SearchStudentsEvent(value)),
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
    return BlocSelector<
      StudentInfoBloc,
      StudentInfoState,
      ({List<StudentModel> students, bool isLoading, String query})
    >(
      selector: (state) => (
        students: state.students,
        isLoading: state.isLoading,
        query: state.searchQuery,
      ),
      builder: (context, data) {
        if (data.isLoading) {
          return const Center(child: AppLoader());
        }

        if (data.query.isEmpty) {
          return _EmptyState(
            icon: Icons.search,
            message: 'Search students by name',
          );
        }

        if (data.students.isEmpty) {
          return _EmptyState(
            icon: Icons.search_off,
            message: 'No Results Found !',
            subMessage: 'Search student details from search bar!',
          );
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: data.students.length,
          itemBuilder: (context, index) {
            return StudentInfoCard(
              student: data.students[index],
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

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? subMessage;

  const _EmptyState({
    required this.icon,
    required this.message,
    this.subMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: context.scale(80),
            color: context.colors.textTertiary.withValues(alpha: 0.3),
          ),
          SizedBox(height: context.scaleHeight(16)),
          Text(
            message,
            style: TextStyle(
              fontSize: context.scaleFont(18),
              fontWeight: FontWeight.bold,
              color: context.colors.textTertiary,
            ),
          ),
          if (subMessage != null) ...[
            SizedBox(height: context.scaleHeight(8)),
            Text(
              subMessage!,
              style: TextStyle(
                fontSize: context.scaleFont(14),
                color: context.colors.textTertiary.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
