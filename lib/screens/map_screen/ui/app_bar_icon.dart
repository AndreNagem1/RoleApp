import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../domain/cubit/filter_cubit.dart';
import 'AppBarButton.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon(
      {super.key, required this.numberOfFilters, required this.filterCubit});

  final int numberOfFilters;
  final FilterCubit filterCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (numberOfFilters > 0)
          Text(
            numberOfFilters.toString(),
            style: GoogleFonts.righteous(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
            ),
          ),
        AppbarButton(
          icon: Icons.filter_alt_outlined,
          filterCubit: filterCubit,
        ),
        const SizedBox(width: 10)
      ],
    );
  }
}
