import 'package:rolesp/models/places_nearby_response.dart';

abstract class MapScreenState {}

class MapsLoading extends MapScreenState {
  List<Object> get props => [];
}

class ErrorState extends MapScreenState {
  List<Object> get props => [];
}

class MapsSetNearbyPlaces extends MapScreenState {
  MapsSetNearbyPlaces(this.nearbyPlacesResponse);

  final NearbyPlacesResponse nearbyPlacesResponse;

  List<Object> get props => [nearbyPlacesResponse];
}
