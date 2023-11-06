import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/screens/map_screen/domain/states/filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit(
      super.initialState, this.listFiltersType, this.listFiltersDistance);

  List<FiltersType> listFiltersType = [];
  List<FiltersDistance> listFiltersDistance = [];

  addFilterType(FiltersType selectedFilter) {
    if (listFiltersType.contains(selectedFilter)) {
      listFiltersType.remove(selectedFilter);
    } else {
      listFiltersType.add(selectedFilter);
    }

    emit(ListFilters(listFiltersType, listFiltersDistance));
  }

  addFilterDistance(FiltersDistance selectedFilter) {
    if (listFiltersDistance.contains(selectedFilter)) {
      listFiltersDistance.remove(selectedFilter);
    } else {
      listFiltersDistance.add(selectedFilter);
    }

    emit(ListFilters(listFiltersType, listFiltersDistance));
  }

  cleanFilters() {
    listFiltersType = [];
    listFiltersDistance = [];

    emit(ListFilters(listFiltersType, listFiltersDistance));
  }
}

enum FiltersType {
  restaurant,
  ar_livre,
  coffee,
  fastfood,
  veggie,
  balad,
}

enum FiltersDistance {
  twoKm,
  fiveKm,
  tenKm,
  twentyFiveKm,
}
