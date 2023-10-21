import 'package:rolesp/models/places_nearby_response.dart';

abstract class SettingsScreenState {}

class InitialState extends SettingsScreenState {
  List<Object> get props => [];
}

class Loading extends SettingsScreenState {
  List<Object> get props => [];
}

class ErrorState extends SettingsScreenState {
  List<Object> get props => [];
}

class NavigateToMap extends SettingsScreenState {
  NavigateToMap(this.nearbyPlacesResponse);

  final NearbyPlacesResponse nearbyPlacesResponse;

  List<Object> get props => [nearbyPlacesResponse];
}

class NavigateToFavorites extends SettingsScreenState {
  NavigateToFavorites(this.nearbyPlacesResponse);

  final NearbyPlacesResponse nearbyPlacesResponse;

  List<Object> get props => [nearbyPlacesResponse];
}
