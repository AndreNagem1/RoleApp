import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/screens/map_screen/domain/states/filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit(super.initialState);

  List<FiltersType> listFiltersType = [FiltersType.restaurant];
  var distanceFilter = 500.0;

  List<FiltersType> listFiltersTypeOnScreen = [FiltersType.restaurant];
  var distanceFilterOnScreen = 500.0;

  var isMakingRequest = false;

  setFiltersOnScreen() {
    listFiltersTypeOnScreen = List.from(listFiltersType);
    distanceFilterOnScreen = distanceFilter;
    emit(InitialState());
  }

  addFilterType(FiltersType selectedFilter) {
    if (listFiltersTypeOnScreen.contains(selectedFilter)) {
      if (listFiltersTypeOnScreen.length > 1) {
        listFiltersTypeOnScreen.remove(selectedFilter);
      }
    } else {
      listFiltersTypeOnScreen.add(selectedFilter);
    }

    emit(AddOrRemoveFilter(listFiltersTypeOnScreen, distanceFilterOnScreen));
  }

  addFilterDistance(double selectedFilter) {
    distanceFilterOnScreen = selectedFilter;

    emit(AddOrRemoveFilter(listFiltersTypeOnScreen, distanceFilterOnScreen));
  }

  cleanFilters() {
    listFiltersType = [FiltersType.restaurant];
    distanceFilter = 500.0;

    listFiltersTypeOnScreen = [FiltersType.restaurant];
    distanceFilterOnScreen = 500.0;

    emit(AddOrRemoveFilter(listFiltersTypeOnScreen, distanceFilterOnScreen));
  }

  filter() {
    isMakingRequest = true;
    listFiltersType = List.from(listFiltersTypeOnScreen);
    distanceFilter = distanceFilterOnScreen;

    emit(MakePlacesRequest(listFiltersType, distanceFilter));
  }
}

enum FiltersType {
  restaurant(['restaurant']),
  outside(['tourist_attraction', 'national_park', 'park', 'zoo', 'dog_park']),
  coffee(['bakery', 'cafe', 'coffee_shop']),
  fastFood(['fast_food_restaurant']),
  veggie(['vegan_restaurant', 'vegetarian_restaurant']),
  nightClub(['bar', 'night_club']);

  const FiltersType(this.filtersList);

  final List<String> filtersList;
}

enum FiltersDistance {
  fiveKm(500.0),
  tenKm(1000.0),
  twentyFiveKm(1500.0);

  const FiltersDistance(this.distance);

  final double distance;
}
