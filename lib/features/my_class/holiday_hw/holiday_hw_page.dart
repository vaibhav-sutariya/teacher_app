import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../core/widgets/app_app_bar.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../cubit/theme_cubit.dart';
import 'bloc/holiday_hw_bloc.dart';
import 'ui/widgets/holiday_hw_card.dart';

@RoutePage()
class HolidayHwPage extends StatelessWidget {
  const HolidayHwPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HolidayHwBloc(repository: sl.get())..add(LoadHolidayHw()),
      child: Scaffold(
        backgroundColor: context.colors.surface100,
        appBar: const AppAppBar(title: 'Holiday Homework'),
        body: BlocBuilder<HolidayHwBloc, HolidayHwState>(
          builder: (context, state) {
            if (state is HolidayHwLoading) {
              return const Center(child: AppLoader());
            } else if (state is HolidayHwLoadedState) {
              if (state.hwList.isEmpty) {
                return _EmptyState();
              }

              return ListView.builder(
                padding: EdgeInsets.all(context.scale(16)),
                itemCount: state.hwList.length,
                itemBuilder: (context, index) {
                  final hw = state.hwList[index];
                  return HolidayHwCard(homework: hw);
                },
              );
            } else if (state is HolidayHwError) {
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
              await context.router.push(const AddHolidayHwRoute());
              if (context.mounted) {
                context.read<HolidayHwBloc>().add(LoadHolidayHw());
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
            Icons.beach_access_outlined,
            size: context.scale(64),
            color: Colors.grey.withValues(alpha: 0.5),
          ),
          SizedBox(height: context.scaleHeight(16)),
          Text(
            'No Holiday Homework Available',
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
