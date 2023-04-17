import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/screens/home_screen/home_screen_state.dart';
import 'package:http/http.dart' as http;

class HomeCubit extends Cubit<HomeScreenState> {
  HomeCubit() : super(InitialState());

  final apiKey = 'AIzaSyAeFQsZFQ1uTHm53Brfxu4AH3R8JBHvj9M';

  Future<void> getNearByPlaces(String category) async {
    emit(Loading());
    var position = await Geolocator.getCurrentPosition();
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
            position.latitude.toString() +
            ',' +
            position.longitude.toString() +
            '&type=restaurant' +
            '&radius=' +
            '2000' +
            '&key=' +
            apiKey);

    var response = await http.post(url);

    var nearbyPlacesResponse =
        NearbyPlacesResponse.fromJson(jsonDecode(response.body));

    var filteredPlaces =
        filterPlacesWithCategory(nearbyPlacesResponse, category);

    emit(NavigateToMap(filteredPlaces));
  }

  NearbyPlacesResponse filterPlacesWithCategory(
    NearbyPlacesResponse nearbyPlacesResponse,
    String category,
  ) {
    List<Results> results = [];
    nearbyPlacesResponse.results?.forEach((place) {
      place.types?.forEach((type) {
        if (type.contains(category)) {
          results.add(place);
        }
      });
    });
    final filteredPlaces = NearbyPlacesResponse(results: results);
    return filteredPlaces;
  }

  Future<void> getFavoritePlaces() async {
    emit(Loading());
    var position = await Geolocator.getCurrentPosition();
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
            position.latitude.toString() +
            ',' +
            position.longitude.toString() +
            '&type=restaurant' +
            '&radius=' +
            '2000' +
            '&key=' +
            apiKey);

    var response = await http.post(url);

    var nearbyPlacesResponse =
    NearbyPlacesResponse.fromJson(jsonDecode(response.body));

    emit(NavigateToFavorites(nearbyPlacesResponse));
  }

  void setInitialState() {
    emit(InitialState());
  }
}
