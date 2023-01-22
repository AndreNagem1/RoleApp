import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolesp/Database/db.dart';

import '../place_details.dart';

class MapController extends GetxController {
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final raio = 0.0.obs;

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
    loadPlaces();

    var style = await rootBundle.loadString('assets/mapDecoration.txt');
    _mapsController.setMapStyle(style);
  }

  loadPlaces() async {
    FirebaseFirestore db = DB.get();
    final cafes = await db.collection('cafes').get();

    for (var cafe in cafes.docs) {
      // addMarker(cafe);
    }
  }

  addMarker(Marker marker, BuildContext context) async {
    markers.add(
      Marker(
          markerId: MarkerId(marker.markerId.value),
          position: LatLng(marker.position.latitude, marker.position.longitude),
          infoWindow: const InfoWindow(title: 'Black Horse'),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            showDetails(marker, context);
          }),
    );
    update();
  }

  showDetails(Marker marker, BuildContext context) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return PlaceDetails(
          key: const Key(''),
          nome: marker.markerId.value,
          image: '',
        );
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
