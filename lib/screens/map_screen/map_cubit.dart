import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/screens/map_screen/map_screen_state.dart';
import 'package:http/http.dart' as http;

class MapCubit extends Cubit<MapScreenState> {
  MapCubit() : super(MapsLoading());

  final apiKey = 'AIzaSyAeFQsZFQ1uTHm53Brfxu4AH3R8JBHvj9M';

  void getNearByPlaces() async {
    //var position = await Geolocator.getCurrentPosition();
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
            '-23.486456' +
            ',' +
            '-46.869430' +
            '&type=restaurant' +
            '&radius=' +
            '1000' +
            '&key=' +
            apiKey);

    var response = await http.post(url);

    var nearbyPlacesResponse =
        NearbyPlacesResponse.fromJson(jsonDecode(response.body));

    if (nearbyPlacesResponse.results != null) {
      emit(MapsSetNearbyPlaces(nearbyPlacesResponse));
    } else {
      emit(ErrorState());
    }
  }
}
