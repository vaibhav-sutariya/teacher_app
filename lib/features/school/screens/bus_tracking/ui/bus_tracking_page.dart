import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import '../bloc/bus_tracking_bloc.dart';
import 'widgets/bus_list_item.dart';

@RoutePage()
class BusTrackingPage extends StatelessWidget {
  const BusTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BusTrackingBloc()..add(LoadBuses()),
      child: const _BusTrackingPageContent(),
    );
  }
}

class _BusTrackingPageContent extends StatelessWidget {
  const _BusTrackingPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface100,
      appBar: AppAppBar(
        title: 'Bus Tracking',
        backgroundColor: context.colors.primary,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<BusTrackingBloc, BusTrackingState>(
        builder: (context, state) {
          if (state is BusTrackingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BusTrackingLoaded) {
            if (state.buses.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.directions_bus_outlined,
                      size: context.scale(64),
                      color: context.colors.textSecondary.withValues(
                        alpha: 0.3,
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(16)),
                    Text(
                      'No buses active at the moment',
                      style: TextStyle(
                        fontSize: context.scaleFont(16),
                        color: context.colors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BusTrackingBloc>().add(RefreshBuses());
              },
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: context.scaleHeight(8)),
                itemCount: state.buses.length,
                itemBuilder: (context, index) {
                  return BusListItem(bus: state.buses[index]);
                },
              ),
            );
          } else if (state is BusTrackingError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
