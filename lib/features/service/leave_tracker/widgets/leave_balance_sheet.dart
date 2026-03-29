import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import '../models/leave_models.dart';

class LeaveBalanceSheet extends StatelessWidget {
  final List<LeaveBalanceModel> balances;

  const LeaveBalanceSheet({super.key, required this.balances});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.scale(20)),
      decoration: BoxDecoration(
        color: context.colors.textInverse,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.scale(20)),
          topRight: Radius.circular(context.scale(20)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Leave Balance',
                style: TextStyle(
                  fontSize: context.scaleFont(18),
                  fontWeight: FontWeight.bold,
                  color: context.colors.textPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(15)),
          ...balances.map((balance) => _buildBalanceRow(context, balance)),
          SizedBox(height: context.scaleHeight(20)),
        ],
      ),
    );
  }

  Widget _buildBalanceRow(BuildContext context, LeaveBalanceModel balance) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(12)),
      padding: EdgeInsets.all(context.scale(12)),
      decoration: BoxDecoration(
        color: context.colors.surface100,
        borderRadius: BorderRadius.circular(context.scale(12)),
        border: Border.all(color: context.colors.divider),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                balance.type,
                style: TextStyle(
                  fontSize: context.scaleFont(14),
                  fontWeight: FontWeight.w600,
                  color: context.colors.textPrimary,
                ),
              ),
              SizedBox(height: context.scaleHeight(4)),
              Text(
                'Used: ${balance.used.toInt()} / ${balance.total.toInt()}',
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  color: context.colors.textSecondary,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(12),
              vertical: context.scaleHeight(6),
            ),
            decoration: BoxDecoration(
              color: context.colors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(context.scale(20)),
            ),
            child: Text(
              'Rem: ${balance.remaining.toInt()}',
              style: TextStyle(
                fontSize: context.scaleFont(12),
                fontWeight: FontWeight.bold,
                color: context.colors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
