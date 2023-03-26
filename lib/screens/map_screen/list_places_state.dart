import 'package:rolesp/models/places_nearby_response.dart';

abstract class ListPlacesState {}

class ListPlacesInitialState extends ListPlacesState {
  List<Object> get props => [];
}

class ListPlaces extends ListPlacesState {
  ListPlaces(this.listPlaces);

  final List<Results> listPlaces;

  List<Object> get props => [listPlaces];
}