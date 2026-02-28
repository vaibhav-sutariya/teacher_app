import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../core/routes/app_router.gr.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile/multi_account/bloc/multi_account_bloc.dart';
import '../../../profile/multi_account/bloc/multi_account_state.dart';
import '../../../profile/multi_account/widgets/multi_account_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.scale(20)),
      child: BlocBuilder<MultiAccountBloc, MultiAccountState>(
        builder: (context, state) {
          final account = state.activeAccount;

          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const MultiAccountBottomSheet(),
                  );
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: context.scale(24),
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      backgroundImage: account?.profileImageUrl != null
                          ? CachedNetworkImageProvider(
                              account!.profileImageUrl!,
                            )
                          : null,
                      child: account?.profileImageUrl == null
                          ? Icon(
                              Icons.person,
                              color: Colors.white,
                              size: context.scale(24),
                            )
                          : null,
                    ),
                    SizedBox(width: context.scale(12)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning,',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: context.scaleFont(12),
                          ),
                        ),
                        Text(
                          account?.name ?? 'User',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: context.scaleFont(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  context.router.push(const NotificationRoute());
                },
                child: Container(
                  padding: EdgeInsets.all(context.scale(8)),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_rounded,
                    color: Colors.white,
                    size: context.scale(24),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
