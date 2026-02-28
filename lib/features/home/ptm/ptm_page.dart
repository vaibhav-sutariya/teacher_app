import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/annotations.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import 'bloc/ptm_bloc.dart';
import 'bloc/ptm_event.dart';
import 'bloc/ptm_state.dart';
import 'widgets/ptm_card.dart';

@RoutePage()
class PtmPage extends StatelessWidget {
  const PtmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PtmBloc()..add(LoadPtms()),
      child: Scaffold(
        appBar: const AppAppBar(title: 'PTM'),
        body: BlocBuilder<PtmBloc, PtmState>(
          builder: (context, state) {
            if (state is PtmLoading || state is PtmInitial) {
              return const Center(child: AppLoader());
            } else if (state is PtmLoaded) {
              if (state.ptms.isEmpty) {
                return const Center(child: Text('No PTMs scheduled.'));
              }

              return ListView.builder(
                padding: EdgeInsets.all(context.scale(20)),
                itemCount: state.ptms.length,
                itemBuilder: (context, index) {
                  final ptm = state.ptms[index];
                  return PtmCard(ptm: ptm);
                },
              );
            } else if (state is PtmError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
