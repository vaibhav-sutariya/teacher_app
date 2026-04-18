import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../core/widgets/month_calendar.dart';
import '../bloc/fees_bloc.dart';
import '../../../models/fees_model.dart';
import 'widgets/fees_collection_tile.dart';
import 'widgets/fees_summary_card.dart';

@RoutePage()
class FeesPage extends StatelessWidget {
  const FeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeesBloc()..add(LoadFeesData(DateTime.now())),
      child: const _FeesPageContent(),
    );
  }
}

class _FeesPageContent extends StatelessWidget {
  const _FeesPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppAppBar(title: 'Fees Collection'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month Calendar Filter
          BlocSelector<FeesBloc, FeesState, DateTime>(
            selector: (state) => state.selectedMonth,
            builder: (context, selectedMonth) {
              return MonthCalendar(
                selectedMonth: selectedMonth,
                onMonthChanged: (newMonth) {
                  context.read<FeesBloc>().add(ChangeSelectedMonth(newMonth));
                },
              );
            },
          ),

          SizedBox(height: context.scaleHeight(8)),

          // Fees Summary Card
          BlocSelector<FeesBloc, FeesState, FeesSummaryModel?>(
            selector: (state) => state.summary,
            builder: (context, summary) {
              if (summary == null) return const SizedBox.shrink();
              return FeesSummaryCard(summary: summary);
            },
          ),

          SizedBox(height: context.scaleHeight(20)),

          // List Title (Collections)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.scale(18)),
            child: Text(
              'Collections',
              style: TextStyle(
                fontSize: context.scaleFont(16),
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          SizedBox(height: context.scaleHeight(8)),

          // Collection List
          Expanded(
            child: BlocBuilder<FeesBloc, FeesState>(
              buildWhen: (previous, current) =>
                  previous.collections != current.collections ||
                  previous.status != current.status,
              builder: (context, state) {
                if (state.status == FeesStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.status == FeesStatus.error) {
                  return Center(child: Text(state.errorMessage ?? 'Error'));
                }

                if (state.collections.isEmpty) {
                  return const Center(child: Text('No collections found'));
                }

                return ListView.builder(
                  padding: EdgeInsets.only(bottom: context.scaleHeight(20)),
                  itemCount: state.collections.length,
                  itemBuilder: (context, index) {
                    return FeesCollectionTile(
                      collection: state.collections[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
