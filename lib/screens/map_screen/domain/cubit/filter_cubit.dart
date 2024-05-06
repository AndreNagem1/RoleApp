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
  restaurant(['restaurant']),
  outside(['tourist_attraction','national_park','park', 'zoo','dog_park']),
  coffee(['bakery', 'cafe', 'coffee_shop']),
  fastFood(['fast_food_restaurant']),
  veggie(['vegan_restaurant', 'vegetarian_restaurant']),
  nightClub(['bar', 'night_club']);

  const FiltersType(this.filtersList);
  final List<String> filtersList;
}

enum FiltersDistance {
  fiveKm('5000'),
  tenKm('10000'),
  twentyFiveKm('15000');

  const FiltersDistance(this.distance);
  final String distance;
}
