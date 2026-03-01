import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../models/dashboard_models.dart';
import 'dashboard_card.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

class AnnouncementsCard extends StatelessWidget {
  const AnnouncementsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, List<AnnouncementModel>>(
      selector: (state) => state.announcements,
      builder: (context, announcements) {
        return DashboardCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DashboardSectionTitle(
                icon: Icons.campaign_outlined,
                iconColor: context.colors.warning,
                title: 'Announcements',
              ),
              SizedBox(height: context.scaleHeight(24)),
              if (announcements.isEmpty) ...[
                Container(
                  height: context.scaleHeight(80),
                  width: context.scale(100),
                  color: context.colors.divider,
                  child: Icon(
                    Icons.image,
                    color: context.colors.textTertiary,
                    size: 48,
                  ),
                ),
                SizedBox(height: context.scaleHeight(16)),
                Text(
                  'No New Announcements!',
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: context.scaleHeight(4)),
                Text(
                  'Any new Details will appear here!',
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    color: context.colors.textSecondary,
                  ),
                ),
                SizedBox(height: context.scaleHeight(16)),
              ] else ...[
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: announcements.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = announcements[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        item.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
