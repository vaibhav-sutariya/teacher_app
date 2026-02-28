import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../models/gate_pass_model.dart';
import 'package:intl/intl.dart';

class GatePassItem extends StatelessWidget {
  final GatePassModel gatePass;

  const GatePassItem({super.key, required this.gatePass});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scale(16)),
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                gatePass.passId,
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF5C6BC0),
                  letterSpacing: 0.5,
                ),
              ),
              _buildStatusBadge(context),
            ],
          ),
          SizedBox(height: context.scaleHeight(12)),

          _buildInfoRow(
            context,
            icon: Icons.person_outline,
            label: 'Request By',
            value: gatePass.requestBy,
          ),
          SizedBox(height: context.scaleHeight(8)),
          _buildInfoRow(
            context,
            icon: Icons.notes_outlined,
            label: 'Reason',
            value: gatePass.reason,
            isMultiLine: true,
          ),
          SizedBox(height: context.scaleHeight(16)),
          Divider(color: Colors.grey.withValues(alpha: 0.1), height: 1),
          SizedBox(height: context.scaleHeight(12)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: context.scale(14),
                      color: Colors.grey[500],
                    ),
                    SizedBox(width: context.scale(6)),
                    Text(
                      DateFormat('MMM dd, yyyy').format(gatePass.date),
                      style: TextStyle(
                        fontSize: context.scaleFont(12),
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: context.scale(14),
                    color: Colors.grey[500],
                  ),
                  SizedBox(width: context.scale(6)),
                  Text(
                    gatePass.formattedTime,
                    style: TextStyle(
                      fontSize: context.scaleFont(12),
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(12),
        vertical: context.scale(4),
      ),
      decoration: BoxDecoration(
        color: gatePass.statusColor,
        borderRadius: BorderRadius.circular(context.scale(12)),
      ),
      child: Text(
        gatePass.statusLabel,
        style: TextStyle(
          fontSize: context.scaleFont(10),
          fontWeight: FontWeight.bold,
          color: gatePass.statusTextColor,
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    bool isMultiLine = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: context.scale(16), color: const Color(0xFF5C6BC0)),
        SizedBox(width: context.scale(8)),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: TextStyle(
                    fontSize: context.scaleFont(13),
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                    fontFamily: 'Manrope', // Assuming font family
                  ),
                ),
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: context.scaleFont(13),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Manrope',
                  ),
                ),
              ],
            ),
            maxLines: isMultiLine ? 2 : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
