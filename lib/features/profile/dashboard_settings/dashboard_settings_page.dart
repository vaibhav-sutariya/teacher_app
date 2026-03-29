import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'bloc/dashboard_settings_bloc.dart';
import 'models/dashboard_setting_item.dart';

@RoutePage()
class DashboardSettingsPage extends StatelessWidget {
  const DashboardSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardSettingsBloc()..add(LoadDashboardSettings()),
      child: Scaffold(
        backgroundColor: context.colors.surface100,
        appBar: const AppAppBar(
          title: 'Dashboard Settings',
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(context.scale(16)),
              color: context.colors.surface,
              child: Text(
                'Customize your Home Dashboard by choosing which modules you want to see. This allows you to focus on what matters most.',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.surface500,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: context.scaleHeight(8)),
            Expanded(
              child: BlocBuilder<DashboardSettingsBloc, DashboardSettingsState>(
                builder: (context, state) {
                  if (state is DashboardSettingsLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: context.colors.primary,
                      ),
                    );
                  } else if (state is DashboardSettingsLoaded) {
                    return ListView.builder(
                      padding: EdgeInsets.all(context.scale(16)),
                      itemCount: state.settings.length,
                      itemBuilder: (context, index) {
                        return _SettingCard(
                          item: state.settings[index],
                        );
                      },
                    );
                  } else if (state is DashboardSettingsError) {
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

class _SettingCard extends StatelessWidget {
  final DashboardSettingItem item;

  const _SettingCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(12)),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(context.scale(16)),
        boxShadow: [
          BoxShadow(
            color: context.colors.surface300.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(context.scale(16)),
        child: InkWell(
          borderRadius: BorderRadius.circular(context.scale(16)),
          onTap: () {
            context
                .read<DashboardSettingsBloc>()
                .add(ToggleDashboardSetting(item.id));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(16),
              vertical: context.scaleHeight(16),
            ),
            child: Row(
              children: [
                // Icon Container
                Container(
                  padding: EdgeInsets.all(context.scale(10)),
                  decoration: BoxDecoration(
                    color: item.isEnabled
                        ? context.colors.primary.withValues(alpha: 0.1)
                        : context.colors.surface300.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.icon,
                    color: item.isEnabled
                        ? context.colors.primary
                        : context.colors.surface500,
                    size: context.scale(24),
                  ),
                ),
                SizedBox(width: context.scale(16)),

                // Texts
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: item.isEnabled
                              ? context.colors.textPrimary
                              : context.colors.surface500,
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(4)),
                      Text(
                        item.description,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colors.surface500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                SizedBox(width: context.scale(12)),

                // Switch Toggle
                CupertinoSwitch(
                  value: item.isEnabled,
                  activeColor: context.colors.primary,
                  onChanged: (bool value) {
                    context
                        .read<DashboardSettingsBloc>()
                        .add(ToggleDashboardSetting(item.id));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
