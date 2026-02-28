import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_tab_bar.dart';
import '../../../../core/widgets/end_of_list_indicator.dart';
import 'bloc/gate_pass_bloc.dart';
import 'bloc/gate_pass_event.dart';
import 'bloc/gate_pass_state.dart';
import 'widgets/gate_pass_item.dart';

@RoutePage()
class GatePassPage extends StatelessWidget {
  const GatePassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GatePassBloc()..add(LoadGatePasses()),
      child: const GatePassView(),
    );
  }
}

class GatePassView extends StatelessWidget {
  const GatePassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7), // Light grey background
      appBar: const AppAppBar(title: 'Gate Pass'),
      body: Column(
        children: [
          // Reusable Tab Bar
          BlocSelector<GatePassBloc, GatePassState, int>(
            selector: (state) => state.selectedTabIndex,
            builder: (context, selectedIndex) {
              return AppTabBar(
                tabs: const ['Student', 'Parents'],
                selectedIndex: selectedIndex,
                onTabChanged: (index) {
                  context.read<GatePassBloc>().add(SwitchTab(index));
                },
              );
            },
          ),

          Expanded(
            child: BlocBuilder<GatePassBloc, GatePassState>(
              builder: (context, state) {
                if (state.status == GatePassPageStatus.loading) {
                  return const Center(child: AppLoader());
                } else if (state.status == GatePassPageStatus.error) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? 'Something went wrong',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state.filteredGatePasses.isEmpty) {
                  return _buildEmptyState(context);
                }

                return ListView.builder(
                  padding: EdgeInsets.all(context.scale(16)),
                  itemCount: state.filteredGatePasses.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.filteredGatePasses.length) {
                      return const EndOfListIndicator();
                    }
                    return GatePassItem(
                      gatePass: state.filteredGatePasses[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.no_accounts_outlined,
            size: context.scale(48),
            color: Colors.grey[400],
          ),
          SizedBox(height: context.scaleHeight(16)),
          Text(
            'No gate passes found',
            style: TextStyle(
              fontSize: context.scaleFont(16),
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
