import 'package:flutter/material.dart';
import 'package:rolesp/screens/map_screen/domain/cubit/filter_cubit.dart';
import 'package:rolesp/screens/map_screen/ui/filter_bottom_sheet.dart';

class AppbarButton extends StatelessWidget {
  final IconData icon;
  final FilterCubit filterCubit;

  const AppbarButton({
    Key? key,
    required this.icon,
    required this.filterCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return FilterBottomSheet(filterCubit: filterCubit);
          },
        ).whenComplete(() => {
              if (filterCubit.shouldSetFiltersOnBottomSheetDispose)
                {filterCubit.setFiltersOnScreen()}
            });
      },
      child: SizedBox(
        width: 40,
        height: 60,
        child: Icon(
          icon,
          size: 33,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
