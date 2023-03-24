import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolesp/Controllers/map_controller.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/screens/map_screen/map_cubit.dart';
import 'package:rolesp/screens/map_screen/map_screen_state.dart';
import 'package:rolesp/widgets/app_title.dart';
import 'package:rolesp/widgets/auto_complete_item.dart';
import 'package:rolesp/widgets/home_search_bar.dart';
import 'package:rolesp/widgets/refrech_button.dart';
import 'package:rolesp/widgets/review_widget.dart';

class MapScreen extends StatelessWidget {
  final NearbyPlacesResponse? places;

  const MapScreen({Key? key, required this.places}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = AutoCompleteCubit();
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: SearchBar(onSearch: (text) {
                        if (text.length > 3) {
                          searchPlaces(cubit, text);
                        }
                      }),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        refreshPlaces(context, controller);
                      },
                      child: const RefreshButton(),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                BlocBuilder<AutoCompleteCubit, AutoCompleteState>(
                    bloc: cubit,
                    builder: (context, state) {
                      if (state is AutoCompletePredictions) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Container(
                            height: 350,
                            alignment: Alignment.topCenter,
                            color: ColorsRoleSp.blackIcon,
                            width: double.infinity,
                            child: ListView.builder(
                              itemBuilder: (context, position) {
                                return Column(
                                  children: [
                                    AutoCompleteItem(
                                      description: state
                                          .listPredictions[position]
                                          .description,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          top: 2.0,
                                          right: 8.0,
                                          bottom: 2.0),
                                      child: Container(
                                        color: ColorsRoleSp.whiteLetter,
                                        height: 0.5,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ],
                                );
                              },
                              itemCount: state.listPredictions.length,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  searchPlaces(AutoCompleteCubit cubit, String text) {
    cubit.searchPlaces(text);
  }

  refreshPlaces(BuildContext context, MapController controller) {
    controller.getNewPlaces(context);
  }
}
