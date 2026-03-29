import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';

import 'bloc/staff_details_bloc.dart';
import 'models/staff_model.dart';
import 'widgets/staff_widgets.dart';

@RoutePage()
class StaffDetailsPage extends StatefulWidget {
  const StaffDetailsPage({super.key});

  @override
  State<StaffDetailsPage> createState() => _StaffDetailsPageState();
}

class _StaffDetailsPageState extends State<StaffDetailsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToLetter(String letter, List<StaffMember> staffList, double itemHeight) {
    final index = staffList.indexWhere(
      (s) => s.name.toUpperCase().startsWith(letter),
    );
    if (index != -1) {
      _scrollController.animateTo(
        index * itemHeight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemHeight = context.scaleHeight(62);
    return BlocProvider(
      create: (context) => StaffDetailsBloc()..add(LoadStaffList()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppAppBar(title: 'Staff Details'),
        body: Column(
          children: [
            // 1. Search Bar
            Builder(
              builder: (context) {
                return StaffSearchBar(
                  onChanged: (query) {
                    context.read<StaffDetailsBloc>().add(SearchStaff(query));
                  },
                );
              },
            ),

            // 2. Main List area with Alphabet Index
            Expanded(
              child: BlocBuilder<StaffDetailsBloc, StaffDetailsState>(
                builder: (context, state) {
                  if (state.status == StaffDetailsStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.status == StaffDetailsStatus.error) {
                    return Center(
                      child: Text(state.errorMessage ?? 'Failed to load staff'),
                    );
                  }

                  if (state.filteredList.isEmpty) {
                    return const Center(child: Text('No employees found'));
                  }

                  return Row(
                    children: [
                      // Staff List
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: state.filteredList.length,
                          itemExtent: itemHeight,
                          padding: EdgeInsets.only(bottom: context.scaleHeight(50)),
                          itemBuilder: (context, index) {
                            return StaffListTile(staff: state.filteredList[index]);
                          },
                        ),
                      ),

                      // Alphabet Index
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: context.scaleHeight(20)),
                        child: AlphabetIndexBar(
                          alphabets: _getAvailableAlphabets(state.filteredList),
                          onSelected: (letter) =>
                              _scrollToLetter(letter, state.filteredList, itemHeight),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getAvailableAlphabets(List<StaffMember> staff) {
    final letters = staff
        .map((s) => s.name.substring(0, 1).toUpperCase())
        .toSet()
        .toList();
    letters.sort();
    return letters;
  }
}
