import 'package:rolesp/screens/map_screen/domain/cubit/filter_cubit.dart';

abstract class FilterState {}

class InitialState extends FilterState {
  InitialState();

  List<Object> get props => [];
}

class MakePlacesRequest extends FilterState {
  MakePlacesRequest(this.listFilterType, this.distanceFilter);

  final List<FiltersType> listFilterType;

  final double distanceFilter;

  List<Object> get props => [listFilterType, distanceFilter];
}

class AddOrRemoveFilter extends FilterState {
  AddOrRemoveFilter(this.listFilterTypeOnScreen, this.distanceFilterOnScreen);

  final List<FiltersType> listFilterTypeOnScreen;

  final double distanceFilterOnScreen;

  List<Object> get props => [listFilterTypeOnScreen, distanceFilterOnScreen];
}

class CleanFilters extends FilterState {
  CleanFilters(this.listFilterType, this.distanceFilter);

  final List<FiltersType> listFilterType;

  final double distanceFilter;

  List<Object> get props => [listFilterType, distanceFilter];
}
