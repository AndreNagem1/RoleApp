import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rolesp/BottomSheets/place_details_bottom_sheet.dart';
import 'package:rolesp/Controllers/map_controller.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/bottomNavigator/map_theme_state.dart';
import 'package:rolesp/models/auto_complete_response.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/screens/map_screen/domain/cubit/autocomplet_cubit.dart';
import 'package:rolesp/screens/map_screen/domain/states/auto_complete_state.dart';
import 'package:rolesp/screens/map_screen/data/datasources/google/google_auto_complete_datasource.dart';
import 'package:rolesp/screens/map_screen/data/repositories/auto_complete_repository_impl.dart';
import 'package:rolesp/screens/map_screen/domain/cubit/list_places_cubit.dart';
import 'package:rolesp/screens/map_screen/domain/states/list_places_state.dart';
import 'package:rolesp/theme/roleTheme.dart';
import 'package:rolesp/widgets/app_title.dart';
import 'package:rolesp/widgets/auto_complete_item.dart';
import 'package:rolesp/widgets/custom_scroll.dart';
import 'package:rolesp/widgets/places_list_item.dart';
import 'package:rolesp/widgets/refrech_button.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MapScreen extends StatelessWidget {
  final NearbyPlacesResponse? places;

  const MapScreen({
    Key? key,
    required this.places,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final datasource = GoogleAutoCompleteDatasource(dio);
    final repository = AutoCompleteRepositoryImpl(datasource);
    final cubit = AutoCompleteCubit(repository);

    final listPlacesCubit = ListPlacesCubit();
    final controller = Get.put(MapController());
    final TextEditingController textFieldController = TextEditingController();
    final listController = AutoScrollController(axis: Axis.horizontal);

    setMapCubit(controller, context, listController, listPlacesCubit);

    var listPlacesList = <Results>[];
    places?.results?.forEach((results) {
      if (results.permanentlyClosed != true) {
        listPlacesList.add(results);
      }
    });

    listPlacesCubit.setListPlaces(listPlacesList);

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
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        refreshPlaces(context, controller, listPlacesCubit);
                      },
                      child: const MapButton(icon: Icons.refresh_sharp),
                    ),
                    const Spacer(),
                    const MapButton(icon: Icons.filter_alt_outlined),
                    const SizedBox(width: 30),
                  ],
                ),
                BlocBuilder<AutoCompleteCubit, AutoCompleteState>(
                  bloc: cubit,
                  builder: (context, state) {
                    if (state is AutoCompletePredictions) {
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
                                            bottom: 2.0,
                                          ),
                                          child: Container(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
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
                const Spacer(),
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
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification is ScrollEndNotification) {
                            final position =
                                listController.position.pixels / 360;

                            focusMarker(controller.listPlaces[position.ceil()],
                                controller);
                          }
                          return false;
                        },
                        child: ListView.builder(
                          physics: const CustomScrollPhysics(snapSize: 360),
                          scrollDirection: Axis.horizontal,
                          controller: listController,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 30.0),
                          itemBuilder: (context, position) {
                            return _getRow(
                              position,
                              listController,
                              state,
                              context,
                              controller,
                            );
                          },
                          itemCount: state.listPlaces.length,
                        ),
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

  setMapCubit(
      MapController controller,
      BuildContext context,
      AutoScrollController listController,
      ListPlacesCubit listPlacesCubit) async {
    controller.setListPlacesController(listController);
    controller.setListPlacesCubit(listPlacesCubit);
    controller.cleanPlaces();
    controller.addPlacesDetails(places ?? NearbyPlacesResponse(), context);
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
    var listPlacesList = <Results>[];
    listPlaces?.forEach((results) {
      if (results.permanentlyClosed != true) {
        listPlacesList.add(results);
      }
    });
    listPlacesCubit.setListPlaces(listPlacesList);
  }

  showDetails(
    BuildContext context,
    Results results,
    MapController mapController,
  ) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return PlaceDetailsBottomSheet(
          key: const Key(''),
          results: results,
          mapController: mapController,
        );
      },
    );
  }

  void focusMarker(Results results, MapController mapController) {
    final markerId = MarkerId(results.name ?? '');
    final marker = Marker(markerId: markerId);
    mapController.showInfoFromMarker(marker.markerId);
  }

  Widget _getRow(
    int index,
    AutoScrollController listPLacesController,
    ListPlaces state,
    BuildContext context,
    MapController mapController,
  ) {
    return _wrapScrollTag(
        index: index,
        child: Row(
          children: [
            const SizedBox(width: 10),
            PlacesListItem(
              results: state.listPlaces[index],
              mapController: mapController,
              onTap: () {
                showDetails(context, state.listPlaces[index], mapController);
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
