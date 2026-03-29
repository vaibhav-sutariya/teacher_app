import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import '../bloc/service_bloc.dart';

class ServiceSearchBar extends StatefulWidget {
  const ServiceSearchBar({super.key});

  @override
  State<ServiceSearchBar> createState() => _ServiceSearchBarState();
}

class _ServiceSearchBarState extends State<ServiceSearchBar> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.scale(20);
    final containerHeight = context.scaleHeight(35);
    final borderRadius = context.scale(12);
    final iconSize = context.scale(18);
    final fontSize = context.scaleFont(14);
    final hintFontSize = context.scaleFont(13);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Container(
        height: containerHeight,
        decoration: BoxDecoration(
          color: context.colors.textInverse.withOpacity(0.15),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: context.colors.textInverse.withOpacity(0.15),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: context.scale(16)),
            Expanded(
              child: TextField(
                focusNode: _focusNode,
                onChanged: (value) {
                  context.read<ServiceBloc>().add(
                    SearchServiceItems(query: value),
                  );
                },
                onTapOutside: (_) {
                  _focusNode.unfocus();
                },
                style: TextStyle(
                  color: context.colors.textInverse,
                  fontSize: fontSize,
                  letterSpacing: 0.3,
                ),
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  hintText: 'Search here...',
                  hintStyle: TextStyle(
                    color: context.colors.textInverse.withOpacity(0.6),
                    fontSize: hintFontSize,
                    letterSpacing: 0.3,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                cursorColor: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.all(context.scale(6)),
              padding: EdgeInsets.all(context.scale(6)),
              decoration: BoxDecoration(
                color: context.colors.textInverse.withOpacity(0.1),
                borderRadius: BorderRadius.circular(context.scale(8)),
              ),
              child: Icon(
                Icons.search,
                color: context.colors.textInverse,
                size: iconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
