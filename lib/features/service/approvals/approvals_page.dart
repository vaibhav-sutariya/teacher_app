import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_tab_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import '../../../../core/widgets/empty_state_view.dart';
import 'bloc/approvals_bloc.dart';
import 'models/approval_models.dart';

@RoutePage()
class ApprovalsPage extends StatelessWidget {
  const ApprovalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApprovalsBloc()..add(LoadApprovals()),
      child: Scaffold(
        backgroundColor: context.colors.surface100,
        appBar: const AppAppBar(
          title: 'My Approvals',
        ),
        body: Column(
          children: [
            // Tabs
            BlocSelector<ApprovalsBloc, ApprovalsState, int>(
              selector: (state) {
                if (state is ApprovalsLoaded) {
                  return state.selectedTabIndex;
                }
                return 0;
              },
              builder: (context, selectedIndex) {
                return AppTabBar(
                  tabs: const ['PENDING', 'APPROVED', 'REJECTED'],
                  selectedIndex: selectedIndex,
                  onTabChanged: (index) {
                    context.read<ApprovalsBloc>().add(ChangeTab(index));
                  },
                );
              },
            ),

            // Tab Content
            Expanded(
              child: BlocBuilder<ApprovalsBloc, ApprovalsState>(
                builder: (context, state) {
                  if (state is ApprovalsLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: context.colors.primary,
                      ),
                    );
                  } else if (state is ApprovalsLoaded) {
                    final List<ApprovalItem> currentList;
                    switch (state.selectedTabIndex) {
                      case 0:
                        currentList = state.peningApprovals;
                        break;
                      case 1:
                        currentList = state.approvedApprovals;
                        break;
                      case 2:
                        currentList = state.rejectedApprovals;
                        break;
                      default:
                        currentList = [];
                    }

                    if (currentList.isEmpty) {
                      return const EmptyStateView();
                    }

                    return ListView.builder(
                      padding: EdgeInsets.all(context.scale(16)),
                      itemCount: currentList.length,
                      itemBuilder: (context, index) {
                        final item = currentList[index];
                        return _ApprovalCard(item: item);
                      },
                    );
                  } else if (state is ApprovalsError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ApprovalCard extends StatelessWidget {
  final ApprovalItem item;
  const _ApprovalCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(12)),
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.scale(10)),
            decoration: BoxDecoration(
              color: context.colors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.type == ApprovalType.leave
                  ? Icons.calendar_today_outlined
                  : Icons.door_front_door_outlined,
              color: context.colors.primary,
              size: context.scale(20),
            ),
          ),
          SizedBox(width: context.scale(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: context.scaleFont(16),
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                ),
                SizedBox(height: context.scaleHeight(4)),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.date,
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  color: context.colors.textTertiary,
                ),
              ),
              SizedBox(height: context.scaleHeight(8)),
              _StatusBadge(status: item.status),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final ApprovalStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case ApprovalStatus.pending:
        color = context.colors.primary;
        label = 'Pending';
        break;
      case ApprovalStatus.approved:
        color = context.colors.success;
        label = 'Approved';
        break;
      case ApprovalStatus.rejected:
        color = context.colors.error;
        label = 'Rejected';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(12),
        vertical: context.scaleHeight(4),
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(context.scale(20)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.scaleFont(10),
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
