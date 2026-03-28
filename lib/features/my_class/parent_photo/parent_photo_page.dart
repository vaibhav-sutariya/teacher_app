import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';

import 'bloc/parent_photo_bloc/parent_photo_bloc.dart';
import 'widgets/parent_photo_class_card.dart';

@RoutePage()
class ParentPhotoPage extends StatelessWidget {
  const ParentPhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParentPhotoBloc()..add(LoadParentPhotoClasses()),
      child: const _ParentPhotoPageContent(),
    );
  }
}

class _ParentPhotoPageContent extends StatelessWidget {
  const _ParentPhotoPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppAppBar(title: 'Parent Photo'),
      body: BlocBuilder<ParentPhotoBloc, ParentPhotoState>(
        builder: (context, state) {
          if (state.status == ParentPhotoStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ParentPhotoStatus.error) {
            return Center(
              child: Text(state.errorMessage ?? 'Error Loading Classes'),
            );
          }

          if (state.classes.isEmpty) {
            return const Center(child: Text('No Classes Found'));
          }

          return ListView.builder(
            itemCount: state.classes.length,
            itemBuilder: (context, index) {
              final classModel = state.classes[index];
              return ParentPhotoClassCard(
                classModel: classModel,
                onTap: () {
                  context.pushRoute(
                    ParentPhotoListRoute(className: classModel.className),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
