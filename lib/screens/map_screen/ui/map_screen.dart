import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolesp/Controllers/map_controller.dart';
import 'package:rolesp/models/auto_complete_response.dart';
import 'package:rolesp/screens/map_screen/domain/cubit/autocomplet_cubit.dart';
import 'package:rolesp/screens/map_screen/domain/cubit/filter_cubit.dart';
import 'package:rolesp/screens/map_screen/domain/cubit/list_places_cubit.dart';
import 'package:rolesp/screens/map_screen/domain/states/filter_state.dart';
import 'package:rolesp/screens/map_screen/ui/places_list.dart';
import 'package:rolesp/widgets/app_title.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../models/nearby_places_response.dart';
import 'app_bar_icon.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({
    Key? key,
    required this.filterCubit,
    required this.listPlacesCubit,
    required this.controller,
  }) : super(key: key);

  final FilterCubit filterCubit;
  final ListPlacesCubit listPlacesCubit;
  final MapController controller;

  @override
  Widget build(BuildContext context) {
    final listController = AutoScrollController(axis: Axis.horizontal);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const AppTitle(),
        backgroundColor: const Color(0x44000000),
        elevation: 0.0,
        actions: [
          BlocBuilder<FilterCubit, FilterState>(
            bloc: filterCubit,
            builder: (context, state) {
              if (state is CleanFilters) {
                listPlacesCubit.setRadiusSearch(state.distanceFilter);
                listPlacesCubit.setListPlacesTypes(state.listFilterType);

                getNearbyPlaces(
                  context,
                  controller,
                  listPlacesCubit,
                  listController,
                );
              }
              if (state is MakePlacesRequest) {
                listPlacesCubit.setRadiusSearch(state.distanceFilter);
                listPlacesCubit.setListPlacesTypes(state.listFilterType);

                getNearbyPlaces(
                  context,
                  controller,
                  listPlacesCubit,
                  listController,
                );
              }

              return AppBarIcon(
                numberOfFilters: listPlacesCubit.listTypesFilter.length,
                filterCubit: filterCubit,
              );
            },
          ),
        ],
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
              onMapCreated: (it) {
                controller.onMapCreated(it, context);
              },
              myLocationEnabled: true,
              rotateGesturesEnabled: false,
              markers: controller.markers,
              myLocationButtonEnabled: false,
              onCameraMove: controller.onCameraMove,
              onTap: (latLong) {
                listPlacesCubit.setInitialState();
              },
            ),
          ),
          PlacesList(
            listPlacesCubit: listPlacesCubit,
            listController: listController,
            mapController: controller,
          )
        ],
      ),
    );
  }

  onSearchSubmittedList(
    BuildContext context,
    MapController controller,
    AutoCompleteCubit cubit,
    Predictions predictions,
  ) {
    final placeId = predictions.placeId;
    controller.getPlaceDetails(context, placeId ?? '');
    cubit.setInitialState();
  }

  onSearchSubmitted(
    BuildContext context,
    MapController controller,
    AutoCompleteCubit cubit,
    String text,
    List<Predictions> listPredictions,
  ) {
    if (listPredictions.isEmpty) {
      cubit.searchPlaces(text);
    }
    final placeId = listPredictions[0].placeId;
    controller.getPlaceDetails(context, placeId ?? '');
    cubit.setInitialState();
  }

  searchPlaces(AutoCompleteCubit cubit, String text) {
    cubit.searchPlaces(text);
  }

  getNearbyPlaces(
    BuildContext context,
    MapController mapController,
    ListPlacesCubit listPlacesCubit,
    AutoScrollController listController,
  ) async {
    controller.setListPlacesCubit(listPlacesCubit);
    controller.setListPlacesController(listController);

    List<PlaceInfo> listPlaces = await listPlacesCubit.getNearByPlaces(context);
    mapController.addPlaceMarker(context, listPlaces);
  }
}
