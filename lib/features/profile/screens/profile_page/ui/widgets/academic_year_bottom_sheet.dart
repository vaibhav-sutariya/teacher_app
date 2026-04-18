import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../../bloc/profile_bloc.dart';

class SelectAcademicYearBottomSheet extends StatelessWidget {
  const SelectAcademicYearBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => current is ProfileLoaded,
      builder: (context, state) {
        if (state is! ProfileLoaded) return const SizedBox.shrink();

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.scale(20),
            vertical: context.scaleHeight(24),
          ),
          decoration: BoxDecoration(
            color: context.colors.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: context.scale(40),
                  height: context.scaleHeight(4),
                  decoration: BoxDecoration(
                    color: context.colors.surface300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: context.scaleHeight(24)),

              // Title
              Text(
                'Select Academic Year',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.scaleHeight(20)),

              // Radio List
              ...state.availableAcademicYears.map((year) {
                final isSelected = state.selectedAcademicYear == year;
                return Padding(
                  padding: EdgeInsets.only(bottom: context.scaleHeight(12)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        context.read<ProfileBloc>().add(
                          SelectAcademicYear(year),
                        );
                        Navigator.pop(
                          context,
                        ); // Close bottom sheet after selection
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.scale(16),
                          vertical: context.scaleHeight(14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? context.colors.primary
                                : context.colors.surface200,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: isSelected
                              ? context.colors.primary.withValues(alpha: 0.05)
                              : null,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: isSelected
                                  ? context.colors.primary
                                  : context.colors.surface500,
                              size: context.scale(22),
                            ),
                            SizedBox(width: context.scale(12)),
                            Expanded(
                              child: Text(
                                year,
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: isSelected
                                      ? context.colors.primary
                                      : context.colors.surface900,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(
                              isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color: isSelected
                                  ? context.colors.primary
                                  : context.colors.surface400,
                              size: context.scale(24),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),

              SizedBox(height: context.scaleHeight(16)),
            ],
          ),
        );
      },
    );
  }
}
