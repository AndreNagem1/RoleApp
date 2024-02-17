import 'package:rolesp/models/nearby_places_response.dart';

abstract class ListPlacesState {}

class ListPlacesInitialState extends ListPlacesState {
  List<Object> get props => [];
}

class ListPlaces extends ListPlacesState {
  ListPlaces(this.listPlaces);

  final List<Places> listPlaces;

  List<Object> get props => [listPlaces];
}

class Loading extends ListPlacesState {
  List<Object> get props => [];
}