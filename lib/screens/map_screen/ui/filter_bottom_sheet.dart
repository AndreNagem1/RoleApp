import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/screens/map_screen/domain/cubit/filter_cubit.dart';
import 'package:rolesp/screens/map_screen/domain/states/filter_state.dart';

import 'draggable_filter.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key, required this.filterCubit});

  final FilterCubit filterCubit;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    var selectedDistanceFilterOnScreen = filterCubit.distanceFilter;
    var selectedTypeFilterListOnScreen = filterCubit.listFiltersType;

    filterCubit.shouldSetFiltersOnBottomSheetDispose = true;

    return Container(
      height: screenHeight * 0.75,
      decoration: const BoxDecoration(
        color: ColorsRoleSp.filterBackGround,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: BlocBuilder<FilterCubit, FilterState>(
          bloc: filterCubit,
          builder: (context, state) {
            if (state is AddOrRemoveFilter) {
              selectedDistanceFilterOnScreen = state.distanceFilterOnScreen;
              selectedTypeFilterListOnScreen = state.listFilterTypeOnScreen;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: Text(
                        'Limpar filtro',
                        style: GoogleFonts.notoSans(
                            color: ColorsRoleSp.whiteLetterNew,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        filterCubit.cleanFilters();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      'Por tipo',
                      style: GoogleFonts.notoSans(
                          color: ColorsRoleSp.whiteLetterNew,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  FilterItemType(
                    filterName: 'Restaurante',
                    isChecked: selectedTypeFilterListOnScreen
                        .contains(FiltersType.restaurant),
                    filtersType: FiltersType.restaurant,
                    onTap: (selectedFilter) {
                      filterCubit.addFilterType(selectedFilter);
                    },
                  ),
                  FilterItemType(
                    filterName: 'Ar Livre',
                    isChecked: selectedTypeFilterListOnScreen
                        .contains(FiltersType.outside),
                    filtersType: FiltersType.outside,
                    onTap: (selectedFilter) {
                      filterCubit.addFilterType(selectedFilter);
                    },
                  ),
                  FilterItemType(
                    filterName: 'Café',
                    isChecked: selectedTypeFilterListOnScreen
                        .contains(FiltersType.coffee),
                    filtersType: FiltersType.coffee,
                    onTap: (selectedFilter) {
                      filterCubit.addFilterType(selectedFilter);
                    },
                  ),
                  FilterItemType(
                    filterName: 'Fastfood',
                    isChecked: selectedTypeFilterListOnScreen
                        .contains(FiltersType.fastFood),
                    filtersType: FiltersType.fastFood,
                    onTap: (selectedFilter) {
                      filterCubit.addFilterType(selectedFilter);
                    },
                  ),
                  FilterItemType(
                    filterName: 'Veggie',
                    isChecked: selectedTypeFilterListOnScreen
                        .contains(FiltersType.veggie),
                    filtersType: FiltersType.veggie,
                    onTap: (selectedFilter) {
                      filterCubit.addFilterType(selectedFilter);
                    },
                  ),
                  FilterItemType(
                    filterName: 'Role',
                    isChecked: selectedTypeFilterListOnScreen
                        .contains(FiltersType.nightClub),
                    filtersType: FiltersType.nightClub,
                    onTap: (selectedFilter) {
                      filterCubit.addFilterType(selectedFilter);
                    },
                  ),
                  const SizedBox(height: 45),
                  Text(
                    'Distância',
                    style: GoogleFonts.notoSans(
                        color: ColorsRoleSp.whiteLetterNew,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 35),
                  FilterDistanceDraggable(
                    setNewDistance: (newDistance) {
                      filterCubit.addFilterDistance(newDistance);
                    },
                    selectedDistanceFilterOnScreen:
                        selectedDistanceFilterOnScreen,
                  ),
                  const SizedBox(height: 65),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(
                          'Filtrar',
                          style: GoogleFonts.notoSans(
                              color: ColorsRoleSp.whiteLetterNew,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsRoleSp.secondaryColorDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            )),
                        onPressed: () {
                          filterCubit.filter();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class FilterItemType extends StatelessWidget {
  const FilterItemType({
    super.key,
    required this.filterName,
    required this.isChecked,
    required this.filtersType,
    required this.onTap,
  });

  final String filterName;
  final bool isChecked;
  final FiltersType filtersType;
  final Function(FiltersType) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          filterName,
          style: GoogleFonts.notoSans(
              color: ColorsRoleSp.whiteLetterNew,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
        const Spacer(),
        SizedBox(
          height: 35,
          child: Checkbox(
              value: isChecked,
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return ColorsRoleSp.whiteLetterNew;
                }
                return Colors.transparent;
              }),
              checkColor: ColorsRoleSp.secondaryColorDark,
              onChanged: (_) {
                onTap(filtersType);
              }),
        ),
      ],
    );
  }
}

class FilterItemDistance extends StatelessWidget {
  const FilterItemDistance({
    super.key,
    required this.filterName,
    required this.isChecked,
    required this.filtersDistance,
    required this.onTap,
  });

  final String filterName;
  final bool isChecked;
  final FiltersDistance filtersDistance;
  final Function(FiltersDistance) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            filterName,
            style: GoogleFonts.righteous(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 35,
            child: Checkbox(
                value: isChecked,
                onChanged: (_) {
                  onTap(filtersDistance);
                }),
          ),
        ],
      ),
    );
  }
}
