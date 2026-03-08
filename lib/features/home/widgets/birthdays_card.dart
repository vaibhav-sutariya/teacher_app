import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../models/dashboard_models.dart';
import 'dashboard_card.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

class BirthdaysCard extends StatelessWidget {
  const BirthdaysCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, List<BirthdayModel>>(
      selector: (state) => state.birthdays,
      builder: (context, birthdays) {
        return DashboardCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardSectionTitle(
                icon: Icons.cake_outlined,
                iconColor: Colors.pinkAccent,
                title: "Today's Birthdays",
              ),
              SizedBox(height: context.scaleHeight(16)),
              if (birthdays.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: Text("No birthdays today")),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: birthdays.length,
                  itemBuilder: (context, index) {
                    final bd = birthdays[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: context.scale(22),
                          backgroundColor: context.colors.warning,
                          child: Text(
                            bd.studentName[0],
                            style: TextStyle(
                              color: context.colors.textInverse,
                              fontWeight: FontWeight.bold,
                              fontSize: context.scaleFont(20),
                            ),
                          ),
                        ),
                        SizedBox(width: context.scale(12)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${bd.studentName} (${bd.gradeSection})',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: context.scaleFont(12),
                                  color: context.colors.textPrimary,
                                ),
                              ),
                              SizedBox(height: context.scaleHeight(4)),
                              Text(
                                DateFormat('dd/MMM/yyyy').format(bd.date),
                                style: TextStyle(
                                  fontSize: context.scaleFont(11),
                                  color: context.colors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
