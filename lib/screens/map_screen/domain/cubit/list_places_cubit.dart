import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rolesp/screens/map_screen/data/entity/GoogleApiController.dart';
import 'package:rolesp/screens/map_screen/domain/states/list_places_state.dart';

import '../../../../models/nearby_places_response.dart';
import 'filter_cubit.dart';

class ListPlacesCubit extends Cubit<ListPlacesState> {
  ListPlacesCubit() : super(ListPlacesInitialState());

  final db = FirebaseFirestore.instance;
  final Dio dio = Dio();
  final apiKey = 'AIzaSyDHqcABOOAoDDqR-UnJA5W7YwDVAa2t884';

  var listPlaces = <PlaceInfo>[];
  var distanceFilter = 500.0;
  var listTypesFilter = [FiltersType.restaurant];

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

  Future<bool> getApiController() async {
    final apiController = <GoogleApiController>[];
    await db.collection('googleApiController').get().then((event) {
      for (var doc in event.docs) {
        final newEvent = GoogleApiController(allowApiCall: doc['allowApiCall']);

        apiController.add(newEvent);
      }
    });

    if (apiController.isEmpty) {
      return false;
    }

    return apiController[0].allowApiCall;
  }

  Future<List<PlaceInfo>> getNearByPlaces(BuildContext context) async {
    emit(Loading());
    final googleApiEnabled = await getApiController();

    if (googleApiEnabled) {
      var position = await Geolocator.getCurrentPosition();
      var url = 'https://places.googleapis.com/v1/places:searchNearby';

      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["X-Goog-Api-Key"] = apiKey;
      dio.options.headers["X-Goog-FieldMask"] =
          "places.displayName,places.formattedAddress,places.types,places.location,places.photos,places.rating,places.currentOpeningHours,places.priceLevel,places.userRatingCount,places.nationalPhoneNumber";

      var listTypes = [];

      for (var filterType in listTypesFilter) {
        listTypes.addAll(filterType.filtersList);
      }

      print('FILTER - PlacesFilters: $listTypes');
      print('FILTER - Radius: $distanceFilter');

      var response = await dio.post(url, data: {
        'includedTypes': listTypes,
        "maxResultCount": "10",
        "locationRestriction": {
          "circle": {
            "center": {
              "latitude": position.latitude.toString(),
              "longitude": position.longitude.toString()
            },
            "radius": distanceFilter
          }
        }
      });

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
        emit(ApiOff());
        throw Exception();
      }
    } else {
      emit(ApiOff());
      return [];
    }
  }

  void setRadiusSearch(double newRadius) {
    distanceFilter = newRadius;
  }

  void setListPlacesTypes(List<FiltersType> newPlacesTypesSearch) {
    listTypesFilter = List.from(newPlacesTypesSearch);
  }
}
