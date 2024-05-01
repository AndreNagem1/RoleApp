import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rolesp/screens/map_screen/data/entity/GoogleApiController.dart';
import 'package:rolesp/screens/map_screen/domain/states/list_places_state.dart';

import '../../../../models/nearby_places_response.dart';

class ListPlacesCubit extends Cubit<ListPlacesState> {
  ListPlacesCubit() : super(ListPlacesInitialState());

  final db = FirebaseFirestore.instance;
  final Dio dio = Dio();
  final apiKey = 'AIzaSyDHqcABOOAoDDqR-UnJA5W7YwDVAa2t884';

  var listPlaces = <PlaceInfo>[];
  var radiusSearch = '500';
  var listTypesSearch = [];

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

      var response = await dio.post(url, data: {
        'includedTypes': listTypesSearch,
        "maxResultCount": "10",
        "locationRestriction": {
          "circle": {
            "center": {
              "latitude": position.latitude.toString(),
              "longitude": position.longitude.toString()
            },
            "radius": radiusSearch
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
        throw Exception();
      }
    } else {
      emit(ApiOff());
      return [];
    }
  }

  void setRadiusSearch(String newRadius) {
    radiusSearch = newRadius;
  }

  void setListPlacesTypes(List<String> newPlacesTypesSearch) {
    listTypesSearch = newPlacesTypesSearch;
  }
}
