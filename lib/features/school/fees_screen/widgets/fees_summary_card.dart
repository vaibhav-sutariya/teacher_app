import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../cubit/theme_cubit.dart';
import '../models/fees_model.dart';

class FeesSummaryCard extends StatelessWidget {
  final FeesSummaryModel summary;

  const FeesSummaryCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.scale(16)),
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMainMetric(
            context,
            label: 'Total Collected',
            amount: summary.totalCollected,
            color: context.colors.primary,
          ),
          SizedBox(height: context.scaleHeight(16)),
          Divider(color: Colors.grey.withValues(alpha: 0.1), height: 1),
          SizedBox(height: context.scaleHeight(16)),
          Row(
            children: [
              Expanded(
                child: _buildSecondaryMetric(
                  context,
                  label: 'Expected',
                  amount: summary.totalExpected,
                  color: Colors.blueGrey,
                  icon: Icons.account_balance_rounded,
                ),
              ),
              Container(
                height: context.scaleHeight(30),
                width: 1,
                color: Colors.grey.withValues(alpha: 0.1),
              ),
              Expanded(
                child: _buildSecondaryMetric(
                  context,
                  label: 'Pending',
                  amount: summary.totalPending,
                  color: Colors.redAccent,
                  icon: Icons.pending_actions_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainMetric(
    BuildContext context, {
    required String label,
    required double amount,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: context.scaleFont(13),
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: context.scaleHeight(4)),
            Text(
              '₹${_formatAmount(amount)}',
              style: TextStyle(
                fontSize: context.scaleFont(22),
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(context.scale(10)),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.payments_outlined,
            color: color,
            size: context.scale(24),
          ),
        ),
      ],
    );
  }

  Widget _buildSecondaryMetric(
    BuildContext context, {
    required String label,
    required double amount,
    required Color color,
    required IconData icon,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: context.scale(14), color: color),
            SizedBox(width: context.scale(4)),
            Text(
              label,
              style: TextStyle(
                fontSize: context.scaleFont(12),
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: context.scaleHeight(4)),
        Text(
          '₹${_formatAmount(amount)}',
          style: TextStyle(
            fontSize: context.scaleFont(15),
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(2)} Cr';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(2)} Lac';
    }
    return amount.toStringAsFixed(0);
  }
}
