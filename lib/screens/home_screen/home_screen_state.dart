import 'package:rolesp/models/places_nearby_response.dart';

abstract class HomeScreenState {}

class InitialState extends HomeScreenState {
  List<Object> get props => [];
}

class Loading extends HomeScreenState {
  List<Object> get props => [];
}

class ErrorState extends HomeScreenState {
  List<Object> get props => [];
}

class NavigateToMap extends HomeScreenState {
  NavigateToMap(this.nearbyPlacesResponse);

  final NearbyPlacesResponse nearbyPlacesResponse;

  List<Object> get props => [nearbyPlacesResponse];
}

class NavigateToFavorites extends HomeScreenState {
  NavigateToFavorites(this.nearbyPlacesResponse);

  final NearbyPlacesResponse nearbyPlacesResponse;

  List<Object> get props => [nearbyPlacesResponse];
}