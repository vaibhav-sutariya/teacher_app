import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/employee_photo_bloc.dart';
import 'widgets/employee_photo_card.dart';

@RoutePage()
class EmployeePhotoPage extends StatelessWidget {
  const EmployeePhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeePhotoBloc()..add(LoadEmployeePhoto()),
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: AppBar(
          backgroundColor: context.colors.primary,
          title: Text(
            'Employee Photo',
            style: TextStyle(color: context.colors.textInverse),
          ),
          iconTheme: IconThemeData(color: context.colors.textInverse),
        ),
        body: BlocBuilder<EmployeePhotoBloc, EmployeePhotoState>(
          builder: (context, state) {
            if (state is EmployeePhotoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmployeePhotoLoaded) {
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => const EmployeePhotoCard(),
              );
            } else if (state is EmployeePhotoError) {
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
