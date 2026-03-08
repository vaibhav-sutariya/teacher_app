import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/new_admission_bloc.dart';
import 'widgets/new_admission_card.dart';

@RoutePage()
class NewAdmissionPage extends StatelessWidget {
  const NewAdmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewAdmissionBloc()..add(LoadNewAdmission()),
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: AppBar(
          backgroundColor: context.colors.primary,
          title: Text(
            'New Admission',
            style: TextStyle(color: context.colors.textInverse),
          ),
          iconTheme: IconThemeData(color: context.colors.textInverse),
        ),
        body: BlocBuilder<NewAdmissionBloc, NewAdmissionState>(
          builder: (context, state) {
            if (state is NewAdmissionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewAdmissionLoaded) {
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => const NewAdmissionCard(),
              );
            } else if (state is NewAdmissionError) {
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
