import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rolesp/models/place_info.dart';
import 'package:http/http.dart' as http;
import 'package:rolesp/screens/map_screen/domain/states/list_places_state.dart';

import '../../../../models/nearby_places_response.dart';
import '../../../../places_categories/PlacesCategories.dart';

class ListPlacesCubit extends Cubit<ListPlacesState> {
  ListPlacesCubit() : super(ListPlacesInitialState());

  final apiKey = 'IX6Sd0VaOzNw7XGa65Xwm1AkpXEfXacI';

  var listPlaces = <PlaceInfo>[];

  void setListPlaces(List<PlaceInfo> listPlaces) {
    if (listPlaces.isNotEmpty) {
      emit(ListPlaces(listPlaces));
    }
  }

  void showPlaceOnList() {
    emit(ListPlaces(listPlaces));
  }

  void setInitialState() {
    emit(ListPlacesInitialState());
  }

  Future<List<PlaceInfo>> getNearByPlaces(BuildContext context) async {
    emit(Loading());

    var position = await Geolocator.getCurrentPosition();

    var url = Uri.parse('https://api.tomtom.com/search/2/nearbySearch/.json?' +
        'key=' +
        apiKey +
        '&lat=' +
        position.latitude.toString() +
        '&lon=' +
        position.longitude.toString() +
        '&language=pt-BR' +
        '&limit=20' +
        '&categorySet=' +
        restaurant);

    var response = await http.get(url);

    var nearbyPlacesResponse = NearbyPlaces.fromJson(jsonDecode(response.body));

    if (nearbyPlacesResponse.results != null) {
      listPlaces = nearbyPlacesResponse.results!;
      emit(ListPlaces(nearbyPlacesResponse.results!));
      return nearbyPlacesResponse.results!;
    }
    emit(ListPlacesInitialState());
    return [];
  }
}
