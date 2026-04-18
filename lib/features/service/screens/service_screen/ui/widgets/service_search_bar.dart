import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import '../../bloc/service_bloc.dart';

class ServiceSearchBar extends StatelessWidget {
  const ServiceSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.scale(14)),
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.textInverse,
          borderRadius: BorderRadius.circular(context.scale(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          onChanged: (value) {
            context.read<ServiceBloc>().add(SearchService(value));
          },
          decoration: InputDecoration(
            hintText: 'Search service...',
            hintStyle: TextStyle(
              color: context.colors.textSecondary,
              fontSize: context.scaleFont(14),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: context.colors.textSecondary,
              size: context.scale(20),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              vertical: context.scaleHeight(12),
            ),
          ),
        ),
      ),
    );
  }
}
