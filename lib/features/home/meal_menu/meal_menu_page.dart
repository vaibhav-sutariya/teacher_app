import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../core/widgets/app_app_bar.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/reusable_calendar_strip.dart';
import 'bloc/meal_menu_bloc.dart';
import 'widgets/meal_menu_card.dart';

@RoutePage()
class MealMenuPage extends StatelessWidget {
  const MealMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealMenuBloc()..add(MealMenuLoaded()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: const AppAppBar(title: 'Meal Menu'),
        body: Column(
          children: [
            // Calendar Strip - Optimized with BlocSelector
            BlocSelector<MealMenuBloc, MealMenuState, DateTime>(
              selector: (state) {
                if (state is MealMenuLoadedState) return state.selectedDate;
                return DateTime.now(); // Fallback
              },
              builder: (context, selectedDate) {
                return ReusableCalendarStrip(
                  selectedDate: selectedDate,
                  onDateSelected: (date) {
                    context.read<MealMenuBloc>().add(MealMenuDateChanged(date));
                  },
                );
              },
            ),

            SizedBox(height: context.scaleHeight(16)),

            Expanded(
              child: BlocBuilder<MealMenuBloc, MealMenuState>(
                builder: (context, state) {
                  if (state is MealMenuLoading) {
                    return const AppLoader();
                  } else if (state is MealMenuLoadedState) {
                    if (state.mealList.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.restaurant_menu_outlined,
                              size: context.scale(64),
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            SizedBox(height: context.scaleHeight(16)),
                            Text(
                              'No Menu Available',
                              style: TextStyle(
                                fontSize: context.scaleFont(16),
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.scale(16),
                      ),
                      itemCount: state.mealList.length,
                      itemBuilder: (context, index) {
                        return MealMenuCard(meal: state.mealList[index]);
                      },
                    );
                  } else if (state is MealMenuError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
