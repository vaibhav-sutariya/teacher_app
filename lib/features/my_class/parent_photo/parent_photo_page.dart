import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/parent_photo_bloc.dart';
import 'widgets/parent_photo_card.dart';

@RoutePage()
class ParentPhotoPage extends StatelessWidget {
  const ParentPhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParentPhotoBloc()..add(LoadParentPhoto()),
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: AppBar(
          backgroundColor: context.colors.primary,
          title: Text(
            'Parent Photo',
            style: TextStyle(color: context.colors.textInverse),
          ),
          iconTheme: IconThemeData(color: context.colors.textInverse),
        ),
        body: BlocBuilder<ParentPhotoBloc, ParentPhotoState>(
          builder: (context, state) {
            if (state is ParentPhotoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ParentPhotoLoaded) {
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => const ParentPhotoCard(),
              );
            } else if (state is ParentPhotoError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: context.colors.error),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
