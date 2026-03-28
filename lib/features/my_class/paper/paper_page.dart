import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../core/widgets/app_app_bar.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../cubit/theme_cubit.dart';
import 'bloc/paper_bloc.dart';
import 'ui/widgets/paper_card.dart';

@RoutePage()
class PaperPage extends StatelessWidget {
  const PaperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaperBloc(repository: sl.get())..add(PaperLoaded()),
      child: Scaffold(
        backgroundColor: context.colors.surface100,
        appBar: const AppAppBar(title: 'Exam Paper'),
        body: BlocBuilder<PaperBloc, PaperState>(
          builder: (context, state) {
            if (state is PaperLoading) {
              return const Center(child: AppLoader());
            } else if (state is PaperLoadedState) {
              if (state.paperList.isEmpty) {
                return _EmptyState();
              }

              return ListView.builder(
                padding: EdgeInsets.all(context.scale(16)),
                itemCount: state.paperList.length,
                itemBuilder: (context, index) {
                  final paper = state.paperList[index];
                  return PaperCard(paper: paper);
                },
              );
            } else if (state is PaperError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(context.scale(20)),
                  child: Text(
                    state.message,
                    style: TextStyle(color: context.colors.error),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () async {
              await context.router.push(const AddPaperRoute());
              if (context.mounted) {
                context.read<PaperBloc>().add(PaperLoaded());
              }
            },
            backgroundColor: context.colors.primary,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: context.scale(64),
            color: Colors.grey.withValues(alpha: 0.5),
          ),
          SizedBox(height: context.scaleHeight(16)),
          Text(
            'No Exam Papers Available',
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
}
