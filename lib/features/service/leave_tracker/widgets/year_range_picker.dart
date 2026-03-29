import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import 'package:intl/intl.dart';

class YearRangePicker extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const YearRangePicker({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MMM-yyyy');
    final rangeText = '${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}';

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: context.scaleHeight(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, size: context.scale(18), color: Colors.black87),
            onPressed: onPrevious,
          ),
          SizedBox(width: context.scale(10)),
          Text(
            rangeText,
            style: TextStyle(
              fontSize: context.scaleFont(14),
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: context.scale(10)),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, size: context.scale(18), color: Colors.black87),
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}
