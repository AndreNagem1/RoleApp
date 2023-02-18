import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolesp/Controllers/map_controller.dart';

class MapPage extends StatelessWidget {
  const MapPage({ Key? key}) : super(key: key);

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
            var marker = Marker(
                markerId: const MarkerId('1'),
                position: LatLng(geoLocation.latitude, geoLocation.longitude));
            controller.addMarker(marker, context);
          },
        ),
      ),
    );
  }
}
