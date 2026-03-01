import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import 'dashboard_card.dart';

class CheckInCard extends StatelessWidget {
  const CheckInCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, bool>(
      selector: (state) => state.isCheckedIn,
      builder: (context, isCheckedIn) {
        return DashboardCard(
          child: Column(
            children: [
              Container(
                height: context.scaleHeight(100),
                width: context.scale(120),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6EFDE),
                  borderRadius: BorderRadius.circular(context.scale(8)),
                ),
                child: Icon(
                  Icons.location_on,
                  size: context.scale(64),
                  color: context.colors.primary,
                ),
              ),
              SizedBox(height: context.scaleHeight(16)),
              SizedBox(
                height: context.scaleHeight(35),
                child: AppPrimaryButton(
                  onPressed: () {},
                  text: isCheckedIn ? 'CLOCK OUT' : 'CHECK-IN',
                  color: isCheckedIn ? Colors.orange : const Color(0xFFFFCA28),
                  textColor: Colors.white,
                  borderRadius: context.scale(24),
                  height: context.scaleHeight(44),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
