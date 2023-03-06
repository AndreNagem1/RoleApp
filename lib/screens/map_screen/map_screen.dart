import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolesp/Controllers/map_controller.dart';
import 'package:rolesp/screens/map_screen/map_cubit.dart';
import 'package:rolesp/screens/map_screen/map_screen_state.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MapController());
    final cubit = MapCubit();

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
      body: BlocBuilder<MapCubit, MapScreenState>(builder: (context, state) {
        if (state is MapsLoading) {
          cubit.getNearByPlaces();
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MapsSetNearbyPlaces) {
          controller.addPlacesToMap(state.nearbyPlacesResponse, context);
          return GetBuilder<MapController>(
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
              onTap: (geoLocation) {},
            ),
          );
        }
        return Container();
      }),
    );
  }
}
