import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_outlined_button.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/app_tab_bar.dart';
import '../../../../core/widgets/empty_state_view.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import 'bloc/punch_approvals_bloc.dart';
import 'models/punch_approval_model.dart';

@RoutePage()
class PunchApprovalsPage extends StatelessWidget {
  const PunchApprovalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PunchApprovalsBloc()..add(LoadPunchApprovals()),
      child: Scaffold(
        backgroundColor: context.colors.surface100,
        appBar: const AppAppBar(
          title: 'Punch Approvals',
        ),
        body: Column(
          children: [
            // Tabs
            BlocSelector<PunchApprovalsBloc, PunchApprovalsState, int>(
              selector: (state) {
                if (state is PunchApprovalsLoaded) {
                  return state.selectedTabIndex;
                }
                return 0;
              },
              builder: (context, selectedIndex) {
                return AppTabBar(
                  tabs: const ['PENDING', 'APPROVED', 'REJECTED'],
                  selectedIndex: selectedIndex,
                  onTabChanged: (index) {
                    context.read<PunchApprovalsBloc>().add(ChangePunchApprovalTab(index));
                  },
                );
              },
            ),

            // Tab Content
            Expanded(
              child: BlocBuilder<PunchApprovalsBloc, PunchApprovalsState>(
                builder: (context, state) {
                  if (state is PunchApprovalsLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: context.colors.primary,
                      ),
                    );
                  } else if (state is PunchApprovalsLoaded) {
                    final List<PunchApproval> currentList;
                    switch (state.selectedTabIndex) {
                      case 0:
                        currentList = state.pendingList;
                        break;
                      case 1:
                        currentList = state.approvedList;
                        break;
                      case 2:
                        currentList = state.rejectedList;
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
                        return _PunchApprovalCard(
                          item: item,
                          isPending: state.selectedTabIndex == 0,
                        );
                      },
                    );
                  } else if (state is PunchApprovalsError) {
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

class _PunchApprovalCard extends StatelessWidget {
  final PunchApproval item;
  final bool isPending;

  const _PunchApprovalCard({
    required this.item,
    required this.isPending,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(10)),
      padding: EdgeInsets.all(context.scale(12)),
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
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(context.scale(8)),
                decoration: BoxDecoration(
                  color: context.colors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.type == PunchType.inPunch
                      ? Icons.login_outlined
                      : Icons.logout_outlined,
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
                      item.name,
                      style: TextStyle(
                        fontSize: context.scaleFont(16),
                        fontWeight: FontWeight.bold,
                        color: context.colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(4)),
                    Text(
                      '${item.date} | ${item.time}',
                      style: TextStyle(
                        fontSize: context.scaleFont(14),
                        color: context.colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusBadge(status: item.status),
            ],
          ),
          if (item.reason != null && item.reason!.isNotEmpty) ...[
            SizedBox(height: context.scaleHeight(12)),
            Container(
              padding: EdgeInsets.all(context.scale(8)),
              decoration: BoxDecoration(
                color: context.colors.surface100,
                borderRadius: BorderRadius.circular(context.scale(8)),
              ),
              child: Text(
                item.reason!,
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  color: context.colors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
          if (isPending) ...[
            SizedBox(height: context.scaleHeight(12)),
            Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {
                      context.read<PunchApprovalsBloc>().add(RejectPunchRequest(item.id));
                    },
                    text: 'REJECT',
                    color: context.colors.error,
                    height: context.scaleHeight(40),
                    borderRadius: context.scale(8),
                  ),
                ),
                SizedBox(width: context.scale(12)),
                Expanded(
                  child: AppPrimaryButton(
                    onPressed: () {
                      context.read<PunchApprovalsBloc>().add(ApprovePunchRequest(item.id));
                    },
                    text: 'APPROVE',
                    height: context.scaleHeight(40),
                    borderRadius: context.scale(8),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final PunchApprovalStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case PunchApprovalStatus.pending:
        color = context.colors.primary;
        label = 'Pending';
        break;
      case PunchApprovalStatus.approved:
        color = context.colors.success;
        label = 'Approved';
        break;
      case PunchApprovalStatus.rejected:
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
