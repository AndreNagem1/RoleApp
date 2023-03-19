import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolesp/Controllers/map_controller.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/widgets/app_title.dart';
import 'package:rolesp/widgets/refrech_button.dart';

class MapScreen extends StatelessWidget {
  final NearbyPlacesResponse? places;

  const MapScreen({Key? key, required this.places}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MapController());
    controller.cleanPlaces();
    controller.addPlacesDetails(places ?? NearbyPlacesResponse(), context);
    if (places == null) {
      controller.getNearByPlaces(context);
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const AppTitle(),
        backgroundColor: const Color(0x44000000),
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          GetBuilder<MapController>(
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
              rotateGesturesEnabled: false,
              markers: controller.markers,
              myLocationButtonEnabled: false,
              onCameraMove: controller.onCameraMove,
            ),
          ),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 100),
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        refreshPlaces(context, controller);
                      },
                      child: const RefreshButton(),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  refreshPlaces(BuildContext context, MapController controller) {
    controller.getNewPlaces(context);
  }
}
