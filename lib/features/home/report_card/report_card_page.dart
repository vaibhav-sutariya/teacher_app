import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import 'bloc/report_card_bloc.dart';
import 'widgets/academic_year_selector.dart';
import 'widgets/report_card_item.dart';

@RoutePage()
class ReportCardPage extends StatelessWidget {
  const ReportCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCardBloc()..add(const LoadReportCards()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F7), // Light grey background
        appBar: const AppAppBar(
          title: 'Report Card',
          // Profile image logic would be here if available
          profileImageUrl: 'https://i.pravatar.cc/300', // Placeholder
        ),
        body: BlocBuilder<ReportCardBloc, ReportCardState>(
          builder: (context, state) {
            String selectedYear = '2024 - 2025';
            List<String> years = ['2023 - 2024', '2024 - 2025'];

            if (state is ReportCardLoaded) {
              selectedYear = state.selectedYear;
              years = state.availableYears;
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(context.scale(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AcademicYearSelector(
                    selectedYear: selectedYear,
                    years: years,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ReportCardBloc>().add(
                          ChangeAcademicYear(value),
                        );
                      }
                    },
                  ),
                  SizedBox(height: context.scaleHeight(24)),
                  Row(
                    children: [
                      Icon(
                        Icons.assignment_turned_in_outlined,
                        color: const Color(0xFF1A237E),
                        size: context.scale(20),
                      ),
                      SizedBox(width: context.scale(8)),
                      Text(
                        'Academic Performance',
                        style: TextStyle(
                          fontSize: context.scaleFont(16),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A237E),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.scaleHeight(16)),
                  _buildContent(context, state),
                  // Footer text based on design
                  SizedBox(height: context.scaleHeight(24)),
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified,
                              color: Colors.grey[400],
                              size: context.scale(16),
                            ),
                            SizedBox(width: context.scale(4)),
                            Text(
                              'OFFICIAL RECORD',
                              style: TextStyle(
                                fontSize: context.scaleFont(10),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.scaleHeight(8)),
                        Text(
                          'All digital reports are official records of St. Joseph\'s Academy.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: context.scaleFont(10),
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(32)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ReportCardState state) {
    if (state is ReportCardLoading) {
      return const Center(
        child: Padding(padding: EdgeInsets.all(32.0), child: AppLoader()),
      );
    } else if (state is ReportCardError) {
      return Center(
        child: Text(state.message, style: const TextStyle(color: Colors.red)),
      );
    } else if (state is ReportCardLoaded) {
      if (state.reportCards.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Text('No reports available for this academic year.'),
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.reportCards.length,
        itemBuilder: (context, index) {
          return ReportCardItem(report: state.reportCards[index]);
        },
      );
    }
    // Initial state or other
    return const Center(
      child: Padding(padding: EdgeInsets.all(32.0), child: AppLoader()),
    );
  }
}
