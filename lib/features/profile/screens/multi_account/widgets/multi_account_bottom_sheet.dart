import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';
import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../cubit/theme_cubit.dart';
import '../bloc/multi_account_bloc.dart';
import '../bloc/multi_account_event.dart';
import '../bloc/multi_account_state.dart';
import '../../../models/account_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MultiAccountBottomSheet extends StatelessWidget {
  const MultiAccountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: context.scale(20),
        right: context.scale(20),
        top: context.scaleHeight(12),
        bottom:
            context.scaleHeight(30) + MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: context.scale(40),
              height: context.scaleHeight(4),
              margin: EdgeInsets.only(bottom: context.scaleHeight(20)),
              decoration: BoxDecoration(
                color: context.colors.surface300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            'Switch Account',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.surface900,
            ),
          ),
          SizedBox(height: context.scaleHeight(16)),
          BlocBuilder<MultiAccountBloc, MultiAccountState>(
            builder: (context, state) {
              if (state.availableAccounts.isEmpty) {
                return const Center(child: Text('No accounts available.'));
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.availableAccounts.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: context.scaleHeight(12)),
                itemBuilder: (context, index) {
                  final account = state.availableAccounts[index];
                  final isSelected = state.activeAccount?.id == account.id;

                  return _buildAccountTile(context, account, isSelected);
                },
              );
            },
          ),
          SizedBox(height: context.scaleHeight(24)),
          _buildAddAccountButton(context),
        ],
      ),
    );
  }

  Widget _buildAccountTile(
    BuildContext context,
    AccountModel account,
    bool isSelected,
  ) {
    return InkWell(
      onTap: () {
        context.read<MultiAccountBloc>().add(
          SwitchAccount(selectedAccount: account),
        );
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(context.scale(12)),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.primary.withValues(alpha: 0.1)
              : context.colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? context.colors.primary
                : context.colors.surface300.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Avatar
            ClipRRect(
              borderRadius: BorderRadius.circular(context.scale(24)),
              child: account.profileImageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: account.profileImageUrl!,
                      width: context.scale(48),
                      height: context.scale(48),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: context.scale(48),
                        height: context.scale(48),
                        color: context.colors.border,
                        child: Icon(
                          Icons.person,
                          color: context.colors.textSecondary,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: context.scale(48),
                        height: context.scale(48),
                        color: context.colors.border,
                        child: Icon(
                          Icons.person,
                          color: context.colors.textSecondary,
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: context.scale(24),
                      backgroundColor: context.colors.surface300,
                      child: Icon(
                        Icons.person,
                        color: context.colors.surface700,
                      ),
                    ),
            ),
            SizedBox(width: context.scale(16)),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.name,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? context.colors.primary
                          : context.colors.surface900,
                    ),
                  ),
                  Text(
                    '${account.role} • ${account.email}',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colors.surface500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Radio button
            Radio<String>(
              value: account.id,
              groupValue: isSelected ? account.id : null,
              activeColor: context.colors.primary,
              onChanged: (String? value) {
                if (value != null) {
                  context.read<MultiAccountBloc>().add(
                    SwitchAccount(selectedAccount: account),
                  );
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddAccountButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.pop(context);
          context.router.push(const LoginRoute());
        },
        icon: Icon(Icons.add, color: context.colors.primary),
        label: Text(
          'Add Student',
          style: TextStyle(
            color: context.colors.primary,
            fontWeight: FontWeight.bold,
            fontSize: context.scaleFont(16),
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: context.scaleHeight(16)),
          side: BorderSide(
            color: context.colors.primary.withValues(alpha: 0.5),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: context.colors.primary.withValues(alpha: 0.05),
        ),
      ),
    );
  }
}
