import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/screens/map_screen/domain/cubit/filter_cubit.dart';
import 'package:rolesp/screens/map_screen/domain/states/filter_state.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key, required this.filterCubit});

  final FilterCubit filterCubit;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: BlocBuilder<FilterCubit, FilterState>(
          bloc: filterCubit,
          builder: (context, state) {
            if (state is ListFilters) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 15.0),
                      child: Text(
                        'Por tipo',
                        style: GoogleFonts.righteous(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    FilterItemType(
                      filterName: 'Restaurante',
                      isChecked:
                          state.listFilterType.contains(FiltersType.restaurant),
                      filtersType: FiltersType.restaurant,
                      onTap: (selectedFilter) {
                        filterCubit.addFilterType(selectedFilter);
                      },
                    ),
                    FilterItemType(
                      filterName: 'Ar Livre',
                      isChecked:
                          state.listFilterType.contains(FiltersType.ar_livre),
                      filtersType: FiltersType.ar_livre,
                      onTap: (selectedFilter) {
                        filterCubit.addFilterType(selectedFilter);
                      },
                    ),
                    FilterItemType(
                      filterName: 'Café',
                      isChecked:
                          state.listFilterType.contains(FiltersType.coffee),
                      filtersType: FiltersType.coffee,
                      onTap: (selectedFilter) {
                        filterCubit.addFilterType(selectedFilter);
                      },
                    ),
                    FilterItemType(
                      filterName: 'Fastfood',
                      isChecked:
                          state.listFilterType.contains(FiltersType.fastfood),
                      filtersType: FiltersType.fastfood,
                      onTap: (selectedFilter) {
                        filterCubit.addFilterType(selectedFilter);
                      },
                    ),
                    FilterItemType(
                      filterName: 'Veggie',
                      isChecked:
                          state.listFilterType.contains(FiltersType.veggie),
                      filtersType: FiltersType.veggie,
                      onTap: (selectedFilter) {
                        filterCubit.addFilterType(selectedFilter);
                      },
                    ),
                    FilterItemType(
                      filterName: 'Role',
                      isChecked:
                          state.listFilterType.contains(FiltersType.balad),
                      filtersType: FiltersType.balad,
                      onTap: (selectedFilter) {
                        filterCubit.addFilterType(selectedFilter);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 15, bottom: 15),
                      child: Text(
                        'Por proximidade',
                        style: GoogleFonts.righteous(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    FilterItemDistance(
                      filterName: '2 Km',
                      isChecked: state.listFilterDistance
                          .contains(FiltersDistance.twoKm),
                      filtersDistance: FiltersDistance.twoKm,
                      onTap: (selectedFilter) {
                        filterCubit.addFilterDistance(selectedFilter);
                      },
                    ),
                    FilterItemDistance(
                      filterName: '5 Km',
                      isChecked: state.listFilterDistance
                          .contains(FiltersDistance.fiveKm),
                      filtersDistance: FiltersDistance.fiveKm,
                      onTap: (selectedFilter) {
                        filterCubit.addFilterDistance(selectedFilter);
                      },
                    ),
                    FilterItemDistance(
                      filterName: '10 Km',
                      isChecked: state.listFilterDistance
                          .contains(FiltersDistance.tenKm),
                      filtersDistance: FiltersDistance.tenKm,
                      onTap: (selectedFilter) {
                        filterCubit.addFilterDistance(selectedFilter);
                      },
                    ),
                    FilterItemDistance(
                      filterName: '25 Km',
                      isChecked: state.listFilterDistance
                          .contains(FiltersDistance.twentyFiveKm),
                      filtersDistance: FiltersDistance.twentyFiveKm,
                      onTap: (selectedFilter) {
                        filterCubit.addFilterDistance(selectedFilter);
                      },
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                            'Filtrar',
                            style: GoogleFonts.righteous(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 12,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Theme.of(context).colorScheme.surface;
                              }
                              return Theme.of(context).colorScheme.secondary;
                            }),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ElevatedButton(
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Limpar filtro',
                            style: GoogleFonts.righteous(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        style: ButtonStyle(
                          elevation:
                              MaterialStateProperty.resolveWith((states) {
                            return 0.0;
                          }),
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.white38;
                            }
                            return Theme.of(context).colorScheme.background;
                          }),
                        ),
                        onPressed: () {
                          filterCubit.cleanFilters();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
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
                  onTap(filtersType);
                }),
          ),
        ],
      ),
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
