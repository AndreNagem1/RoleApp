import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/screens/home_screen/home_screen_state.dart';
import 'package:http/http.dart' as http;

class HomeCubit extends Cubit<HomeScreenState> {
  HomeCubit() : super(Loading());

  final apiKey = 'AIzaSyAeFQsZFQ1uTHm53Brfxu4AH3R8JBHvj9M';

  void getNearByPlaces() async {
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

    if (nearbyPlacesResponse.results != null) {
      emit(SetNearbyPlaces(nearbyPlacesResponse));
    } else {
      emit(ErrorState());
    }
  }
}
