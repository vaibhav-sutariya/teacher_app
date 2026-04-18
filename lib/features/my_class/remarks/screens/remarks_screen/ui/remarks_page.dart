import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/app_loader.dart';
import 'package:teachers_app/core/widgets/error_state.dart';
import '../../../../../../core/routes/app_router.gr.dart';
import '../bloc/remark_bloc.dart';
import '../bloc/remark_event.dart';
import '../bloc/remark_state.dart';
import 'widgets/remark_card.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

@RoutePage()
class RemarksPage extends StatelessWidget {
  const RemarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RemarkBloc()..add(const RefreshRemarksEvent()),
      child: const _RemarksPageContent(),
    );
  }
}

class _RemarksPageContent extends StatelessWidget {
  const _RemarksPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(
        title: 'Remarks',
        actions: [
          TextButton(
            onPressed: () {
              // Custom Filter Dropdown action
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'All',
                  style: TextStyle(
                    fontSize: context.scaleFont(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(Icons.arrow_drop_down, size: context.scale(24)),
              ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<RemarkBloc, RemarkState>(
        buildWhen: (previous, current) =>
            previous.isLoading != current.isLoading ||
            previous.errorMessage != current.errorMessage ||
            previous.remarks != current.remarks,
        builder: (context, state) {
          if (state.isLoading && state.remarks.isEmpty) {
            return const Center(child: AppLoader());
          }

          if (state.errorMessage != null && state.remarks.isEmpty) {
            return ErrorState(
              message: state.errorMessage!,
              onRetry: () =>
                  context.read<RemarkBloc>().add(const RefreshRemarksEvent()),
            );
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: context.scaleHeight(100)),
            itemCount: state.remarks.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: Colors.grey.shade300,
              indent: context.scale(16),
              endIndent: context.scale(16),
            ),
            itemBuilder: (context, index) {
              final remark = state.remarks[index];
              // Fallback mock data mapping for student names to simulate the image exactly
              final names = [
                'Panchal Hiyansh Hardik',
                'Bhatt Shrija Chintan',
                'Sharma Anay Abhinandan',
                'Ramoliya Jenil Ashishkumar',
                'Shah Aayushi Hiren',
                'Ramnani Dheer Pravinkumar',
                'Shah Bhavya Alpeshkumar',
                'Maheshwari Charvi Ajay',
                'Kadam Mayra Vinayak',
                'Patel Harshil Priteshkumar',
                'Panchal Jiyan Dharmesh',
                'Solanki Nihal Kirtibhai',
                'Parmar Devansh Jignesh',
              ];
              // Use index to pick a name, wrapping around if needed
              final studentName = names[index % names.length];

              // Simple avatar placeholder string for mock purposes
              final avatarUrl = 'https://i.pravatar.cc/150?u=remark_\$index';

              return RepaintBoundary(
                child: RemarkCard(
                  remark: remark,
                  studentName: studentName,
                  studentImage: avatarUrl,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add Remark Action
          context.router.push(const RemarksEntryRoute());
        },
        backgroundColor: const Color(0xFFE88A34), // Orange matched from image
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }
}
