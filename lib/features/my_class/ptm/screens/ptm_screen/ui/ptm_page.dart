import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/annotations.dart';
import '../../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../../core/widgets/app_app_bar.dart';
import '../../../../../../../core/widgets/app_loader.dart';
import '../../../../../../core/routes/app_router.gr.dart';
import '../bloc/ptm_bloc.dart';
import '../bloc/ptm_event.dart';
import '../bloc/ptm_state.dart';
import '../../../models/ptm_model.dart';
import 'widgets/ptm_card.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

@RoutePage()
class PtmPage extends StatelessWidget {
  const PtmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PtmBloc()..add(LoadPtms()),
      child: Scaffold(
        appBar: const AppAppBar(title: 'PTM'),
        body: BlocSelector<PtmBloc, PtmState, bool>(
          selector: (state) => state is PtmLoading || state is PtmInitial,
          builder: (context, isLoading) {
            if (isLoading) {
              return const Center(child: AppLoader());
            }
            return const _PtmList();
          },
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () =>
                  context.router.push(const AddPtmRoute()).then((_) {
                    if (context.mounted) {
                      context.read<PtmBloc>().add(LoadPtms());
                    }
                  }),
              backgroundColor: context.colors.primary,
              child: const Icon(Icons.add, color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}

class _PtmList extends StatelessWidget {
  const _PtmList();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PtmBloc, PtmState, List<PtmModel>>(
      selector: (state) {
        if (state is PtmLoaded) return state.ptms;
        return [];
      },
      builder: (context, ptms) {
        if (ptms.isEmpty) {
          return const Center(child: Text('No PTMs scheduled.'));
        }

        return ListView.builder(
          padding: EdgeInsets.all(context.scale(20)),
          itemCount: ptms.length,
          itemBuilder: (context, index) {
            final ptm = ptms[index];
            return RepaintBoundary(
              key: ValueKey('ptm_${ptm.id}'),
              child: PtmCard(ptm: ptm),
            );
          },
        );
      },
    );
  }
}
