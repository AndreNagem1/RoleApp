import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolesp/BottomSheets/place_details_bottom_sheet.dart';
import 'package:rolesp/Controllers/map_controller.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/models/auto_complete_response.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/screens/map_screen/autocomplet_cubit.dart';
import 'package:rolesp/screens/map_screen/auto_complete_state.dart';
import 'package:rolesp/screens/map_screen/list_places_cubit.dart';
import 'package:rolesp/screens/map_screen/list_places_state.dart';
import 'package:rolesp/widgets/app_title.dart';
import 'package:rolesp/widgets/auto_complete_item.dart';
import 'package:rolesp/widgets/home_search_bar.dart';
import 'package:rolesp/widgets/places_list_item.dart';
import 'package:rolesp/widgets/refrech_button.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MapScreen extends StatelessWidget {
  final NearbyPlacesResponse? places;

  const MapScreen({Key? key, required this.places}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = AutoCompleteCubit();
    final listPlacesCubit = ListPlacesCubit();
    final controller = Get.put(MapController());
    List<Predictions> listPredictions = List.empty();
    final TextEditingController textFieldController = TextEditingController();
    final listController = AutoScrollController(axis: Axis.horizontal);

    controller.setListPlacesController(listController);
    controller.setListPlacesCubit(listPlacesCubit);
    controller.cleanPlaces();
    controller.addPlacesDetails(places ?? NearbyPlacesResponse(), context);
    listPlacesCubit.setListPlaces(places?.results ?? List.empty());

    if (places == null) {
      controller.setListPlaces(places?.results ?? List.empty());
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
              onTap: (latLong) {
                listPlacesCubit.setInitialState();
                cubit.setInitialState();
              },
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
                      child: SearchBar(
                        controller: textFieldController,
                        onSearch: (text) {
                          if (text.length > 3) {
                            searchPlaces(cubit, text);
                            return;
                          }
                          cubit.setInitialState();
                        },
                        onSubmitted: (text) {
                          onSearchSubmitted(
                            context,
                            controller,
                            cubit,
                            text,
                            listPredictions,
                          );
                        },
                        onTap: () {
                          listPlacesCubit.setInitialState();
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        refreshPlaces(context, controller, listPlacesCubit);
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
                      listPredictions = state.listPredictions;

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 20.0, top: 5),
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color: ColorsRoleSp.searchBackground,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  itemBuilder: (context, position) {
                                    return Column(
                                      children: [
                                        AutoCompleteItem(
                                            description: state
                                                .listPredictions[position]
                                                .description,
                                            onTap: () {
                                              textFieldController.clear();
                                              onSearchSubmittedList(
                                                context,
                                                controller,
                                                cubit,
                                                state.listPredictions[position],
                                              );
                                            }),
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
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<ListPlacesCubit, ListPlacesState>(
              bloc: listPlacesCubit,
              builder: (context, state) {
                if (state is ListPlaces) {
                  controller.setShouldGenerateNewListPlaces(false);
                  controller.listPlaces = state.listPlaces;

                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 330,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: listController,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 30.0),
                        itemBuilder: (context, position) {
                          return _getRow(
                              position, listController, state, context);
                        },
                        itemCount: state.listPlaces.length,
                      ),
                    ),
                  );
                }
                controller.setShouldGenerateNewListPlaces(true);
                return const SizedBox();
              }),
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

  refreshPlaces(
    BuildContext context,
    MapController controller,
    ListPlacesCubit listPlacesCubit,
  ) async {
    List<Results>? listPlaces = await controller.getNewPlaces(context);
    listPlacesCubit.setListPlaces(listPlaces ?? List.empty());
  }

  showDetails(
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

  Widget _getRow(
    int index,
    AutoScrollController listPLacesController,
    ListPlaces state,
    BuildContext context,
  ) {
    return _wrapScrollTag(
        index: index,
        child: Row(
          children: [
            const SizedBox(width: 15),
            PlacesListItem(
              results: state.listPlaces[index],
              onTap: () {
                showDetails(context, state.listPlaces[index]);
              },
            )
          ],
        ),
        listPlacesController: listPLacesController);
  }

  Widget _wrapScrollTag(
          {required int index,
          required Widget child,
          required AutoScrollController listPlacesController}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: listPlacesController,
        index: index,
        child: child,
        highlightColor: Colors.black.withOpacity(0.1),
      );
}
