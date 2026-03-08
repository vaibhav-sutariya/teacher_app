import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/birthday_bloc.dart';
import 'widgets/birthday_card.dart';

@RoutePage()
class BirthdayPage extends StatelessWidget {
  const BirthdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BirthdayBloc()..add(LoadBirthday()),
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: AppBar(
          backgroundColor: context.colors.primary,
          title: Text(
            'Birthday',
            style: TextStyle(color: context.colors.textInverse),
          ),
          iconTheme: IconThemeData(color: context.colors.textInverse),
        ),
        body: BlocBuilder<BirthdayBloc, BirthdayState>(
          builder: (context, state) {
            if (state is BirthdayLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BirthdayLoaded) {
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => const BirthdayCard(),
              );
            } else if (state is BirthdayError) {
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
