import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:rolesp/models/place_details_response.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/screens/map_screen/list_places_cubit.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MapController extends GetxController {
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final raio = 0.0.obs;
  final apiKey = 'AIzaSyAeFQsZFQ1uTHm53Brfxu4AH3R8JBHvj9M';

  late StreamSubscription<Position> positionStream;
  LatLng _position = const LatLng(-23.4944928, -46.8575523);
  late GoogleMapController _mapsController;
  late ListPlacesCubit listPlacesCubit;
  late AutoScrollController listPlacesController;
  late List<Results> listPlaces;
  final markers = <Marker>{};
  late bool shouldGenerateNewListPLaces = false;

  static MapController get to => Get.find<MapController>();

  get mapsController => _mapsController;

  get position => _position;

  String get distancia => raio.value < 1
      ? '${(raio.value * 1000).toStringAsFixed(0)} m'
      : '${(raio.value).toStringAsFixed(1)} km';

  void showInfoFromMarker(MarkerId markerId) {
    _mapsController.showMarkerInfoWindow(markerId);
  }

  void setShouldGenerateNewListPlaces(bool generate) {
    shouldGenerateNewListPLaces = generate;
  }

  void setListPlacesCubit(ListPlacesCubit cubit) {
    listPlacesCubit = cubit;
  }

  void setListPlacesController(AutoScrollController listController) {
    listPlacesController = listController;
  }

  void setListPlaces(List<Results> listResults) {
    listPlaces = listResults;
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  void onCameraMove(CameraPosition position) {
    _position = position.target;
  }

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    getPosition();

    var style = await rootBundle.loadString('assets/mapDecoration.txt');
    _mapsController.setMapStyle(style);
  }

  zoomIn() {
    _mapsController.moveCamera(CameraUpdate.zoomBy(11));
  }

  moveCameraToPosition(LatLng position) {
    _mapsController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 15.0),
      ),
    );
  }

  addMarker(Marker marker, BuildContext context, Results results,
      int listIndex) async {
    markers.add(
      Marker(
          markerId: MarkerId(marker.markerId.value),
          position: LatLng(marker.position.latitude, marker.position.longitude),
          infoWindow: InfoWindow(title: marker.markerId.value),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            showPlaceOnList(listIndex);
          }),
    );
    update();
  }

  cleanPlaces() {
    markers.clear();
  }

  Future<List<Results>?> getNewPlaces(BuildContext context) async {
    cleanPlaces();

    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?' +
            'location=' +
            _position.latitude.toString() +
            ',' +
            _position.longitude.toString() +
            '&type=restaurant' +
            '&radius=' +
            '2000' +
            '&language=pt&key=' +
            apiKey);

    var response = await http.post(url);

    var nearbyPlacesResponse =
        NearbyPlacesResponse.fromJson(jsonDecode(response.body));

    if (nearbyPlacesResponse.results != null) {
      addPlacesDetails(nearbyPlacesResponse, context);
      return nearbyPlacesResponse.results;
    }
    return List.empty();
  }

  getPlaceDetails(BuildContext context, String placeId) async {
    cleanPlaces();

    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?' +
            'place_id=' +
            placeId +
            '&language=pt&key=' +
            apiKey);

    var response = await http.post(url);
    var details = PlaceDetailsResponse.fromJson(jsonDecode(response.body));

    if (details.result != null) {
      final lat = details.result?.geometry?.location?.lat ?? 0.0;
      final lng = details.result?.geometry?.location?.lng ?? 0.0;

      LatLng position = LatLng(lat, lng);
      moveCameraToPosition(position);
    }
  }

  getNearByPlaces(BuildContext context) async {
    var position = await Geolocator.getCurrentPosition();
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?' +
            'location=' +
            position.latitude.toString() +
            ',' +
            position.longitude.toString() +
            '&type=restaurant' +
            '&radius=' +
            '2000' +
            '&language=pt&key=' +
            apiKey);

    var response = await http.post(url);

    var nearbyPlacesResponse =
        NearbyPlacesResponse.fromJson(jsonDecode(response.body));

    if (nearbyPlacesResponse.results != null) {
      listPlaces = nearbyPlacesResponse.results ?? List.empty();
      addPlacesDetails(nearbyPlacesResponse, context);
    }
  }

  getNearByPlacesDetails(
    BuildContext context,
    Results results,
    int listIndex,
  ) async {
    final placeId = results.placeId;

    if (placeId != null) {
      var call = 'https://maps.googleapis.com/maps/api/place/details/json?' +
          'fields=website,opening_hours/weekday_text,formatted_phone_number&' +
          '&place_id=' +
          placeId +
          '&key=' +
          apiKey;

      var url = Uri.parse(call);
      var response = await http.post(url);

      var details = PlaceDetailsResponse.fromJson(jsonDecode(response.body));

      if (details.result?.openingHours != null) {
        results.openingHours?.daysOpeningHours =
            details.result?.openingHours?.weekdayText;
      }
      if (details.result?.formattedPhoneNumber != null) {
        results.phone = details.result?.formattedPhoneNumber;
      }

      if (details.result?.website != null) {
        results.website = details.result?.website;
      }
    }

    addPlaceMarker(context, results, listIndex);
  }

  addPlaceMarker(BuildContext context, Results response, int listIndex) {
    var id = response.name!;
    var lat = response.geometry!.location!.lat!;
    var lng = response.geometry!.location!.lng!;

    var marker = Marker(
      markerId: MarkerId(id),
      position: LatLng(lat, lng),
    );
    var addNewMarker = true;
    if (response.permanentlyClosed == true) {
      addNewMarker = false;
    }
    if (addNewMarker) {
      addMarker(marker, context, response, listIndex);
    }
  }

  addPlacesDetails(
    NearbyPlacesResponse places,
    BuildContext context,
  ) {
    if (places.results != null) {
      var index = 0;
      while (index < places.results!.length) {
        final response = places.results?[index];
        if (response != null) {
          getNearByPlacesDetails(context, response, index);
        }
        index++;
      }
    }
  }

  showPositionOnMap(Results results) {
    final lat = results.geometry?.location?.lat ?? 0.0;
    final lng = results.geometry?.location?.lng ?? 0.0;
    final position = LatLng(lat, lng);
    if (position.latitude != 0.0 && position.longitude != 0.0) {
      moveCameraToPosition(position);
    }
  }

  Future showPlaceOnList(int index) async {
    if (shouldGenerateNewListPLaces) {
      listPlacesCubit.setListPlaces(listPlaces);
      await Future.delayed(const Duration(milliseconds: 50));
    }
    final indexList = index - 1;
    var position = indexList * 360;

    if (position < 0) {
      position = 0;
    }
    listPlacesController.jumpTo(position.toDouble());
  }

  watchPosition() async {
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      latitude.value = position.latitude;
      longitude.value = position.longitude;
    });
  }

  @override
  void onClose() {
    positionStream.cancel();
    super.onClose();
  }

  Future<Position> _currentPosition() async {
    LocationPermission permission;
    bool ativado = await Geolocator.isLocationServiceEnabled();

    if (!ativado) {
      return Future.error('Por favor, habilite a localização no smartphone.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso à localização.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Autorize o acesso à localização nas configurações.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Position> getUserPosition()  async {
    final position= await _currentPosition();
    return position;
  }

 Future<Position> getPosition()  async {
    try {
      final position = await _currentPosition();
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      _mapsController.animateCamera(
          CameraUpdate.newLatLng(LatLng(latitude.value, longitude.value)));
      return position;
    } catch (e) {
      Get.snackbar(
        'Erro',
        e.toString(),
        backgroundColor: Colors.grey[900],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return position;
 }
}
