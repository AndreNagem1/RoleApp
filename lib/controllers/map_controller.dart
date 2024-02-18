import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolesp/models/nearby_places_response.dart';
import 'package:rolesp/screens/map_screen/domain/cubit/list_places_cubit.dart';
import 'package:rolesp/theme/roleTheme.dart';
import 'package:scroll_to_index/scroll_to_index.dart';


class MapController extends GetxController {
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final radius = 0.0.obs;

  late StreamSubscription<Position> positionStream;
  LatLng _position = const LatLng(-23.4944928, -46.8575523);
  late GoogleMapController _mapsController;
  late ListPlacesCubit listPlacesCubit;
  late AutoScrollController listPlacesController;
  List<PlaceInfo>? listPlaces = [];
  final markers = <Marker>{};
  late bool shouldGenerateNewListPLaces = false;
  late String distanceSearchNearbyPlaces = '2000';
  late String nearByPlacesType = 'restaurant';

  static MapController get to => Get.find<MapController>();

  get mapsController => _mapsController;

  get position => _position;

  String get distance => radius.value < 1
      ? '${(radius.value * 1000).toStringAsFixed(0)} m'
      : '${(radius.value).toStringAsFixed(1)} km';

  void showInfoFromMarker(PlaceInfo? placeInfo) {
    final markerId = MarkerId(placeInfo?.displayName?.text ?? '');
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

  void setListPlaces(List<PlaceInfo> listResults) {
    listPlaces = listResults;
  }

  void setFilters(String placesTypes, String distance) {
    nearByPlacesType = placesTypes;
    distanceSearchNearbyPlaces = distance;
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

  onMapCreated(GoogleMapController gmc, BuildContext context) async {
    _mapsController = gmc;

    getPosition();
    setMapDecoration(Theme.of(context).colorScheme == lightColorScheme);
  }

  setMapDecoration(bool isLight) async {
    var decoration = 'assets/mapDecoration.txt';

    if (isLight) {
      decoration = 'assets/mapDecorationLight.txt';
    }

    var style = await rootBundle.loadString(decoration);
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

  addPlaceMarker(BuildContext context ,List<PlaceInfo> places) {
    for (var place in places) {
      listPlaces?.add(place);

      var id = place.displayName?.text ?? '';
      var lat = place.location?.latitude ?? 0;
      var lng = place.location?.longitude ?? 0;

      var marker = Marker(
        markerId: MarkerId(id),
        position: LatLng(lat, lng),
      );

      addMarker(marker, context,  places.indexOf(place));
    }
  }

  addMarker(Marker marker, BuildContext context, int listIndex) async {
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

  getPlaceDetails(BuildContext context, String placeId) async {
    cleanPlaces();
  }

  showPlaceInfoOnMap(PlaceInfo placeInfo) {
    final lat = placeInfo.location?.latitude ?? 0;
    final lng = placeInfo.location?.longitude ?? 0;
    final position = LatLng(lat, lng);
    if (position.latitude != 0.0 && position.longitude != 0.0) {
      moveCameraToPosition(position);
    }
  }

  Future showPlaceOnList(int index) async {
    if (shouldGenerateNewListPLaces) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    final indexList = index - 1;
    var position = indexList * 360;

    if (position < 0) {
      position = 0;
    }
    listPlacesCubit.showPlaceOnList();
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

  Future<Position> getUserPosition() async {
    final position = await _currentPosition();
    return position;
  }

  Future<Position> getPosition() async {
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
