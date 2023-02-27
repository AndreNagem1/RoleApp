import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolesp/Controllers/map_controller.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);
  final apiKey = 'AIzaSyAeFQsZFQ1uTHm53Brfxu4AH3R8JBHvj9M';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MapController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Stack(
          children: [
            Text(
              "RoleSp",
              style: GoogleFonts.righteous(
                color: Colors.white,
                textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 30,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Colors.black,
                ),
              ),
            ),
            Text(
              "RoleSp",
              style: GoogleFonts.righteous(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0x44000000),
        elevation: 0.0,
      ),
      body: GetBuilder<MapController>(
        init: controller,
        builder: (value) => GoogleMap(
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: controller.position,
            zoom: 13,
          ),
          onMapCreated: controller.onMapCreated,
          myLocationEnabled: true,
          markers: controller.markers,
          onTap: (geoLocation) {
            getNearByPlaces();
            var marker = Marker(
                markerId: const MarkerId('1'),
                position: LatLng(geoLocation.latitude, geoLocation.longitude));
            controller.addMarker(marker, context);
          },
        ),
      ),
    );
  }

  void getNearByPlaces() async {
    var position = await Geolocator.getCurrentPosition();
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
            position.latitude.toString() +
            ',' +
            position.longitude.toString() +
            '&radius=' +
            '30' +
            '&key=' +
            apiKey);

    var response = await http.post(url);
    debugPrint('MEU PRINT' + response.toString());
  }
}
