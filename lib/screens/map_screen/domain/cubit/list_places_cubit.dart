import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolesp/screens/map_screen/data/entity/GoogleApiController.dart';
import 'package:rolesp/screens/map_screen/domain/states/list_places_state.dart';

import '../../../../constants.dart';
import '../../../../models/nearby_places_response.dart';
import 'filter_cubit.dart';

class ListPlacesCubit extends Cubit<ListPlacesState> {
  ListPlacesCubit() : super(ListPlacesInitialState());

  final db = FirebaseFirestore.instance;
  final Dio dio = Dio(BaseOptions(receiveTimeout: const Duration(seconds: 10)));
  final apiKey = 'apiKey';

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

  Future<List<PlaceInfo>> getNearByPlaces(
      BuildContext context, LatLng currentPosition) async {
    emit(Loading());
    final listPLacesFromDB = await getNearbyPlacesFromDB(
        currentPosition.latitude, currentPosition.longitude);

    if (listPLacesFromDB.isNotEmpty) {
      emit(ListPlaces(listPLacesFromDB));
      print('$appTag veio do DB');
      return listPLacesFromDB;
    } else {
      print('$appTag veio da API');
      return getNearByPlacesGoogleApi(context, currentPosition);
    }
  }

  Future<List<PlaceInfo>> getNearByPlacesGoogleApi(
      BuildContext context, LatLng currentPosition) async {
    final googleApiEnabled = await getApiController();

    if (googleApiEnabled) {
      var position = currentPosition;
      var url = 'https://places.googleapis.com/v1/places:searchNearby';

      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["X-Goog-Api-Key"] = apiKey;
      dio.options.headers["X-Goog-FieldMask"] = "places.displayName," +
          "places.formattedAddress," +
          "places.types," +
          "places.location," +
          "places.photos," +
          "places.rating," +
          "places.currentOpeningHours," +
          "places.priceLevel," +
          "places.userRatingCount," +
          "places.nationalPhoneNumber," +
          "places.accessibilityOptions," +
          "places.allowsDogs," +
          "places.goodForChildren," +
          "places.liveMusic," +
          "places.servesVegetarianFood," +
          "places.id,";

      var listTypes = [];

      for (var filterType in listTypesFilter) {
        listTypes.addAll(filterType.filtersList);
      }

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
          sendPlacesToDB(nearbyPlacesResponse.places!);

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

  Future<List<PlaceInfo>> getNearbyPlacesFromDB(double lat, double lon) async {
    final zone = getPosition(lat, lon);
    List<PlaceInfo> listPlaces = [];

    try {
      await db.collection(zone).get().then((event) {
        for (var doc in event.docs) {
          final daysOfWeek =
              DaysOffWeekJson.fromJson(jsonDecode(doc['openingHours']));

          List<Photos> listPhotos = [];

          List<String> listPhotosUrl = doc['photos'].toString().split(',');

          var counter = 0;
          while (counter < listPhotosUrl.length) {
            listPhotos.add(Photos(name: listPhotosUrl[counter]));
            counter++;
          }

          final placeInfo = PlaceInfo(
              displayName: DisplayName(
                text: doc['name'],
              ),
              phoneNumber: doc['phoneNumber'],
              location: Location(
                  latitude: doc['latitude'], longitude: doc['longitude']),
              rating: doc['rating'],
              websiteUri: doc['websiteUri'],
              businessStatus: doc['businessStatus'],
              priceLevel: doc['priceLevel'],
              userRatingCount: doc['userRatingCount'],
              liveMusic: doc['liveMusic'],
              goodForChildren: doc['goodForChildren'],
              allowsDogs: doc['allowsDogs'],
              servesVegetarianFood: doc['servesVegetarianFood'],
              accessibilityOptions: AccessibilityOptions(
                  wheelchairAccessibleEntrance:
                      doc['wheelchairAccessibleEntrance']),
              formattedAddress: doc['formattedAddress'],
              photos: listPhotos,
              currentOpeningHours: RegularOpeningHours(weekdayDescriptions: [
                daysOfWeek.seg ?? "",
                daysOfWeek.ter ?? "",
                daysOfWeek.qua ?? "",
                daysOfWeek.qui ?? "",
                daysOfWeek.sex ?? "",
                daysOfWeek.sab ?? "",
                daysOfWeek.dom ?? "",
              ]));

          listPlaces.add(placeInfo);
        }
      });
    } catch (error) {
      print('$appTag Failed to update document: $error');
    }

    return listPlaces;
  }

  void setRadiusSearch(double newRadius) {
    distanceFilter = newRadius;
  }

  void setListPlacesTypes(List<FiltersType> newPlacesTypesSearch) {
    listTypesFilter = List.from(newPlacesTypesSearch);
  }

  void sendPlacesToDB(List<PlaceInfo> places) {
    places.forEach((place) async {
      final neighborhood = getPosition(
          place.location?.latitude ?? 0.0, place.location?.longitude ?? 0.0);

      List<String> listPhotosUrl = [];
      var counter = 0;

      final size = place.photos?.length ?? 0.0;
      while (size > counter) {
        listPhotosUrl.add(place.photos?[counter].name ?? '');
        counter++;
      }

      Map<String, dynamic> data = {
        'name': place.displayName?.text,
        'formattedAddress': place.formattedAddress ?? '',
        'phoneNumber': place.phoneNumber,
        'latitude': place.location?.latitude,
        'longitude': place.location?.longitude,
        'rating': place.rating,
        'websiteUri': place.websiteUri,
        'businessStatus': place.businessStatus,
        'priceLevel': place.priceLevel,
        'userRatingCount': place.userRatingCount,
        'liveMusic': place.liveMusic,
        'goodForChildren': place.goodForChildren,
        'allowsDogs': place.allowsDogs,
        'servesVegetarianFood': place.servesVegetarianFood,
        'neighborhood': neighborhood,
        'wheelchairAccessibleEntrance':
            place.accessibilityOptions?.wheelchairAccessibleEntrance,
        'openingHours': getOpeningHours(place),
        'photos': listPhotosUrl.join(','),
      };

      if (neighborhood != 'Out of bounds' && place.id?.isNotEmpty == true) {
        try {
          await db.collection(neighborhood).doc(place.id).set(data);
        } catch (error) {
          print('$appTag Failed to update document: $error');
        }
      }
    });
  }
}

String getOpeningHours(PlaceInfo place) {
  final daysOpeningHours = place.currentOpeningHours?.weekdayDescriptions;
  return '''
  {
    "seg": "${daysOpeningHours?[0].replaceAll('Monday', 'Seg.').replaceAll('Closed', 'Fechado')}",
    "ter": "${daysOpeningHours?[1].replaceAll('Tuesday', 'Ter.').replaceAll('Closed', 'Fechado')}",
    "qua": "${daysOpeningHours?[2].replaceAll('Wednesday', 'Quart.').replaceAll('Closed', 'Fechado')}",
    "qui": "${daysOpeningHours?[3].replaceAll('Thursday', 'Quint.').replaceAll('Closed', 'Fechado')}",
    "sex": "${daysOpeningHours?[4].replaceAll('Friday', 'Sex.').replaceAll('Closed', 'Fechado')}",
    "sab": "${daysOpeningHours?[5].replaceAll('Saturday', 'Sab.').replaceAll('Closed', 'Fechado')}",
    "dom": "${daysOpeningHours?[6].replaceAll('Sunday', 'Dom.').replaceAll('Closed', 'Fechado')}"
  }
  ''';
}

const double fiveKmInLong = 0.04901;
const double fiveKmInLat = 0.04497;

const double initialLatPosition = -23.716101;

const double initialLongPosition = -46.970144;

String getPosition(double lat, double lon) {
  // Check if the latitude and longitude are within the valid range
  if (lat < initialLatPosition ||
      lat > (initialLatPosition + fiveKmInLat * 9) ||
      lon < initialLongPosition ||
      lon > (initialLongPosition + fiveKmInLong * 12)) {
    return 'Out of bounds';
  }

  // Calculate the latitude and longitude indices
  int latIndex = ((lat - initialLatPosition) / fiveKmInLat).floor();
  int lonIndex = ((lon - initialLongPosition) / fiveKmInLong).floor();

  // Ensure indices are within the valid range
  if (latIndex < 0 || latIndex >= 7 || lonIndex < 0 || lonIndex >= 10) {
    return 'Out of bounds';
  }

  // Map latitude index to letter
  String latArea = (latIndex + 1).toString();

  // Map longitude index to number
  String lonArea = String.fromCharCode('A'.codeUnitAt(0) + lonIndex);

  return '$lonArea$latArea';
}

const double R = 6371.0;

double haversine(double lat1, double lon1, double lat2, double lon2) {
  double dLat = (lat2 - lat1) * pi / 180.0;
  double dLon = (lon2 - lon1) * pi / 180.0;

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1 * pi / 180.0) *
          cos(lat2 * pi / 180.0) *
          sin(dLon / 2) *
          sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return R * c;
}

// Function to sort a list of places by distance from a given point
List<PlaceInfo> sortPlacesByDistance(
    double currentLat, double currentLon, List<PlaceInfo> places) {
  places.sort((place1, place2) {
    double distance1 = haversine(currentLat, currentLon,
        place1.location?.latitude ?? 0.0, place1.location?.longitude ?? 0.0);
    double distance2 = haversine(currentLat, currentLon,
        place2.location?.latitude ?? 0.0, place2.location?.longitude ?? 0.0);
    return distance1.compareTo(distance2);
  });
  return places;
}
