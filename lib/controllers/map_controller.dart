import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:rolesp/Database/db.dart';
import 'package:rolesp/models/place_details_response.dart';
import 'package:rolesp/models/places_nearby_response.dart';

import '../BottomSheets/place_details_bottom_sheet.dart';

class MapController extends GetxController {
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final raio = 0.0.obs;
  final apiKey = 'AIzaSyAeFQsZFQ1uTHm53Brfxu4AH3R8JBHvj9M';

  late StreamSubscription<Position> positionStream;
  final LatLng _position = const LatLng(-23.4944928, -46.8575523);
  late GoogleMapController _mapsController;
  final markers = <Marker>{};

  static MapController get to => Get.find<MapController>();

  get mapsController => _mapsController;

  get position => _position;

  String get distancia => raio.value < 1
      ? '${(raio.value * 1000).toStringAsFixed(0)} m'
      : '${(raio.value).toStringAsFixed(1)} km';

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  filtrarCafes() {
    final geo = Geoflutterfire();
    final db = DB.get();

    GeoFirePoint center = geo.point(
      latitude: latitude.value,
      longitude: longitude.value,
    );

    CollectionReference<Map<String, dynamic>> ref = db.collection('cafes');

    String field = 'position';

    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: ref)
        .within(center: center, radius: raio.value, field: field);

    stream.listen((List<DocumentSnapshot> cafes) {
      markers.clear();
      cafes.forEach((cafe) {
        // addMarker(cafe);
        update();
      });
      Get.back();
    });
  }

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    getPosition();

    var style = await rootBundle.loadString('assets/mapDecoration.txt');
    _mapsController.setMapStyle(style);
    zoomIn();
  }

  zoomIn() {
    _mapsController.moveCamera(CameraUpdate.zoomBy(0.8));
  }

  addMarker(Marker marker, BuildContext context, Results results) async {
    markers.add(
      Marker(
          markerId: MarkerId(marker.markerId.value),
          position: LatLng(marker.position.latitude, marker.position.longitude),
          infoWindow: InfoWindow(title: marker.markerId.value),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            showDetails(marker, context, results);
          }),
    );
    update();
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
            '&key=' +
            apiKey);

    var response = await http.post(url);

    var nearbyPlacesResponse =
        NearbyPlacesResponse.fromJson(jsonDecode(response.body));

    if (nearbyPlacesResponse.results != null) {
      addPlacesDetails(nearbyPlacesResponse, context);
    }
  }

  getNearByPlacesDetails(
    BuildContext context,
    Results results,
  ) async {
    final placeId = results.placeId;

    if (placeId != null) {
      var call = 'https://maps.googleapis.com/maps/api/place/details/json?' +
          'fields=opening_hours/weekday_text,formatted_phone_number&' +
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
    }

    addPlaceMarker(context, results);
  }

  addPlaceMarker(BuildContext context, Results response) {
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
      addMarker(marker, context, response);
    }
  }

  addPlacesDetails(
    NearbyPlacesResponse nearbyPlacesResponse,
    BuildContext context,
  ) {
    var index = 0;
    while (index < nearbyPlacesResponse.results!.length) {
      final response = nearbyPlacesResponse.results?[index];
      if (response != null) {
        getNearByPlacesDetails(
          context,
          response,
        );
      }
      index++;
    }
  }

  showDetails(
    Marker marker,
    BuildContext context,
    Results results,
  ) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return PlaceDetailsBottomSheet(key: const Key(''), results: results);
      },
    );
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

  getPosition() async {
    try {
      final position = await _currentPosition();
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      _mapsController.animateCamera(
          CameraUpdate.newLatLng(LatLng(latitude.value, longitude.value)));
    } catch (e) {
      Get.snackbar(
        'Erro',
        e.toString(),
        backgroundColor: Colors.grey[900],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
