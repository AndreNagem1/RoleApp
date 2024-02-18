import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rolesp/screens/map_screen/domain/states/list_places_state.dart';

import '../../../../models/nearby_places_response.dart';

class ListPlacesCubit extends Cubit<ListPlacesState> {
  ListPlacesCubit() : super(ListPlacesInitialState());

  final Dio dio = Dio();
  final apiKey = 'AIzaSyB3mOnY0N_AtY67Q4gZcJkbzC-95QrdbmY';

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

    var url = 'https://places.googleapis.com/v1/places:searchNearby';

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["X-Goog-Api-Key"] = apiKey;
    dio.options.headers["X-Goog-FieldMask"] = "places.displayName,places.formattedAddress,places.types,places.location";

    var response = await dio.post(
        url,
        data: {
          'includedTypes': ["restaurant"],
          "maxResultCount": "20",
          "locationRestriction": {
            "circle": {
              "center": {
                "latitude": position.latitude.toString(),
                "longitude": position.longitude.toString()
              },
              "radius": "500"
            }
          }
        }
    );

    if (response.statusCode == 200) {
       var nearbyPlacesResponse = NearbyPlacesResponse.fromJson(response.data);

      if (nearbyPlacesResponse.places != null) {
        listPlaces = nearbyPlacesResponse.places!;
        emit(ListPlaces(nearbyPlacesResponse.places!));
        return nearbyPlacesResponse.places!;
      }
      emit(ListPlacesInitialState());
      return [];
    } else {
      throw Exception();
    }
  }
}
