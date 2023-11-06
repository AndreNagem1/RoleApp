import 'package:rolesp/screens/map_screen/domain/cubit/filter_cubit.dart';

abstract class FilterState {}

class ListFilters extends FilterState {
  ListFilters(this.listFilterType, this.listFilterDistance);

  final List<FiltersType> listFilterType;

  final List<FiltersDistance> listFilterDistance;

  List<Object> get props => [listFilterType, listFilterDistance];
}
