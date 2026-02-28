import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../core/widgets/app_app_bar.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/pdf_document_card.dart';
import 'bloc/holiday_hw_bloc.dart';

@RoutePage()
class HolidayHwPage extends StatelessWidget {
  const HolidayHwPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HolidayHwBloc()..add(HolidayHwLoaded()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: const AppAppBar(title: 'Holiday HW'),
        body: BlocBuilder<HolidayHwBloc, HolidayHwState>(
          builder: (context, state) {
            if (state is HolidayHwLoading) {
              return const Center(child: AppLoader());
            } else if (state is HolidayHwLoadedState) {
              if (state.holidayHwList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.beach_access_outlined,
                        size: context.scale(64),
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      SizedBox(height: context.scaleHeight(16)),
                      Text(
                        'No Holiday Homework Available',
                        style: TextStyle(
                          fontSize: context.scaleFont(16),
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.all(context.scale(16)),
                itemCount: state.holidayHwList.length,
                itemBuilder: (context, index) {
                  final holidayHw = state.holidayHwList[index];
                  return PdfDocumentCard(
                    id: holidayHw.id,
                    date: holidayHw.date,
                    subject: holidayHw.subject,
                    type: holidayHw.type,
                    color: holidayHw.color,
                    pdfUrl: holidayHw.pdfUrl,
                    icon: Icons.beach_access_outlined,
                  );
                },
              );
            } else if (state is HolidayHwError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
