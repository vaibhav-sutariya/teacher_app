import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../models/fees_model.dart';

class FeesCollectionTile extends StatelessWidget {
  final FeesCollectionModel collection;

  const FeesCollectionTile({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(6),
      ),
      padding: EdgeInsets.all(context.scale(12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(12)),
        border: Border.all(color: Colors.grey.shade100, width: 1),
      ),
      child: Row(
        children: [
          // Left: Student Avatar/Initials
          Container(
            width: context.scale(44),
            height: context.scale(44),
            decoration: BoxDecoration(
              color: _getStatusColor().withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(context.scale(10)),
            ),
            child: Center(
              child: Text(
                _getInitials(collection.studentName),
                style: TextStyle(
                  fontSize: context.scaleFont(16),
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor(),
                ),
              ),
            ),
          ),
          SizedBox(width: context.scale(12)),

          // Middle: Student Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  collection.studentName,
                  style: TextStyle(
                    fontSize: context.scaleFont(15),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.scaleHeight(2)),
                Row(
                  children: [
                    Text(
                      'Class: ${collection.studentClass}',
                      style: TextStyle(
                        fontSize: context.scaleFont(12),
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(width: context.scale(8)),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: context.scale(8)),
                    Text(
                      DateFormat('dd MMM').format(collection.date),
                      style: TextStyle(
                        fontSize: context.scaleFont(12),
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Right: Amount and Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${collection.amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: context.scaleFont(16),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: context.scaleHeight(4)),
              _buildStatusBadge(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(6),
        vertical: context.scaleHeight(2),
      ),
      decoration: BoxDecoration(
        color: _getStatusColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.scale(4)),
      ),
      child: Text(
        collection.status.name.toUpperCase(),
        style: TextStyle(
          fontSize: context.scaleFont(8),
          fontWeight: FontWeight.bold,
          color: _getStatusColor(),
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (collection.status) {
      case FeesPaymentStatus.paid:
        return Colors.green.shade600;
      case FeesPaymentStatus.pending:
        return Colors.orange.shade700;
      case FeesPaymentStatus.partial:
        return Colors.blue.shade600;
    }
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'NA';
    final parts = name.trim().split(' ');
    if (parts.length > 1) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }
}
