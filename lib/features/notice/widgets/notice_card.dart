import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../models/notice_model.dart';

class NoticeCard extends StatelessWidget {
  final NoticeModel notice;

  const NoticeCard({super.key, required this.notice});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(8),
      ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  notice.title,
                  style: TextStyle(
                    fontSize: context.scaleFont(16),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.scale(8),
                  vertical: context.scaleHeight(4),
                ),
                decoration: BoxDecoration(
                  color: context.colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(context.scale(5)),
                ),
                child: Text(
                  DateFormat('dd MMM').format(notice.date),
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    fontWeight: FontWeight.w600,
                    color: context.colors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(10)),
          Text(
            notice.description,
            style: TextStyle(
              fontSize: context.scaleFont(14),
              color: Colors.black54,
              height: 1.4,
            ),
          ),
          SizedBox(height: context.scaleHeight(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: context.scale(16),
                    color: Colors.grey,
                  ),
                  SizedBox(width: context.scale(4)),
                  Text(
                    notice.postedBy,
                    style: TextStyle(
                      fontSize: context.scaleFont(12),
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              if (notice.attachmentUrl != null)
                Icon(
                  Icons.attachment,
                  size: context.scale(18),
                  color: context.colors.primary,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
