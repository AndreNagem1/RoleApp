import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/screens/map_screen/domain/cubit/filter_cubit.dart';
import 'package:rolesp/screens/map_screen/domain/states/filter_state.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key, required this.filterCubit});

  final FilterCubit filterCubit;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.72,
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
            if (state is ListFilters) {
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
                    const SizedBox(height: 45),
                    Text(
                      'Distância',
                      style: GoogleFonts.notoSans(
                          color: ColorsRoleSp.whiteLetterNew,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 35),
                    const FilterDistanceDraggable(),
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
                          onPressed: () => Navigator.pop(context),
                        ),
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

class FilterDistanceDraggable extends StatefulWidget {
  const FilterDistanceDraggable({super.key});

  @override
  State<FilterDistanceDraggable> createState() =>
      _FilterDistanceDraggableState();
}

class _FilterDistanceDraggableState extends State<FilterDistanceDraggable> {
  var offSetAxisX = 0.0;
  var alignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    if(offSetAxisX > 10){
      alignment = Alignment.centerLeft;
    }

    if(offSetAxisX > 100){
      alignment = Alignment.centerRight;
    }
      return Draggable(
      child:  DraggableInitialState(
          alignment: alignment
      ),
      feedback: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: ColorsRoleSp.secondaryColorDark),
      ),
      onDragEnd: (dragDetails) {
        setState(() {
          offSetAxisX = dragDetails.offset.dx;
        });
      },
      axis: Axis.horizontal,
    );
  }
}

class DraggableInitialState extends StatelessWidget {
  const DraggableInitialState({super.key, required this.alignment});

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: alignment,
      children: [
        const Divider(
          color: ColorsRoleSp.secondaryColorDark,
          thickness: 4.0,
        ),
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: ColorsRoleSp.secondaryColorDark),
        ),
      ],
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
