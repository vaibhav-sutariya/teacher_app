import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/month_calendar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import 'bloc/enquiry_bloc.dart';
import 'widgets/enquiry_list_item.dart';

@RoutePage()
class EnquiryPage extends StatelessWidget {
  const EnquiryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EnquiryBloc()..add(LoadEnquiries()),
      child: const _EnquiryPageContent(),
    );
  }
}

class _EnquiryPageContent extends StatelessWidget {
  const _EnquiryPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(
        title: 'Enquiry',
        backgroundColor: context.colors.primary,
        foregroundColor: Colors.white,
        actions: [
          _AcademicYearDropdown(),
        ],
      ),
      body: Column(
        children: [
          // 1. Month Calendar Navigation
          BlocBuilder<EnquiryBloc, EnquiryState>(
            buildWhen: (p, c) => p.selectedMonth != c.selectedMonth,
            builder: (context, state) {
              return MonthCalendar(
                selectedMonth: state.selectedMonth,
                onMonthChanged: (newMonth) {
                  context.read<EnquiryBloc>().add(ChangeEnquiryMonth(newMonth));
                },
              );
            },
          ),

          // 2. Enquiry List
          Expanded(
            child: BlocBuilder<EnquiryBloc, EnquiryState>(
              builder: (context, state) {
                if (state is EnquiryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is EnquiryLoaded) {
                  if (state.enquiries.isEmpty) {
                    return const Center(child: Text('No enquiries found'));
                  }
                  return ListView.builder(
                    itemCount: state.enquiries.length,
                    itemBuilder: (context, index) {
                      return EnquiryListItem(
                        enquiry: state.enquiries[index],
                        index: index,
                      );
                    },
                  );
                } else if (state is EnquiryError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AcademicYearDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: context.scale(16)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '2025-2026',
            style: TextStyle(
              fontSize: context.scaleFont(14),
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
            size: context.scale(20),
          ),
        ],
      ),
    );
  }
}
