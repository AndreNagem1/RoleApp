import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Controllers/map_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../BottomSheets/place_details_bottom_sheet/place_details_bottom_sheet.dart';
import '../../../models/nearby_places_response.dart';
import '../../../widgets/custom_scroll.dart';
import '../../../widgets/places_list_item.dart';
import '../../../widgets/refrech_button.dart';
import '../domain/cubit/list_places_cubit.dart';
import '../domain/states/list_places_state.dart';

class PlacesList extends StatelessWidget {
  final ListPlacesCubit listPlacesCubit;
  final AutoScrollController listController;
  final MapController mapController;

  const PlacesList(
      {super.key,
      required this.listPlacesCubit,
      required this.mapController,
      required this.listController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListPlacesCubit, ListPlacesState>(
      bloc: listPlacesCubit,
      builder: (context, state) {
        if (state is ListPlaces) {
          mapController.setShouldGenerateNewListPlaces(false);
          mapController.listPlaces = state.listPlaces;

          return Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 330,
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification) {
                    final position = listController.position.pixels / 360;

                    mapController.showInfoFromMarker(
                        mapController.listPlaces?[position.ceil()]);
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
                      mapController,
                    );
                  },
                  itemCount: state.listPlaces.length,
                ),
              ),
            ),
          );
        }
        if (state is Loading) {
          mapController.cleanPlaces();

          return Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black26,
              alignment: Alignment.center,
              child: const CircularProgressIndicator());
        }
        if (state is ApiOff) {
          return GestureDetector(
            onTap: () {
              listPlacesCubit.setInitialState();
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black26,
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'API Desligada',
                    style: GoogleFonts.righteous(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        mapController.setShouldGenerateNewListPlaces(true);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 120),
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    getNearbyPlaces(context, mapController, listPlacesCubit);
                  },
                  child: const MapButton(icon: Icons.refresh_sharp),
                ),
                const SizedBox(width: 35),
              ],
            ),
          ],
        );
      },
    );
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
              place: state.listPlaces[index],
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

  getNearbyPlaces(
    BuildContext context,
    MapController mapController,
    ListPlacesCubit listPlacesCubit,
  ) async {
    List<PlaceInfo> listPlaces = await listPlacesCubit.getNearByPlaces(context, mapController.position);
    mapController.addPlaceMarker(context, listPlaces);
  }

  showDetails(
    BuildContext context,
    PlaceInfo placeInfo,
    MapController mapController,
  ) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return PlaceDetailsBottomSheet(
          key: const Key(''),
          place: placeInfo,
          mapController: mapController,
        );
      },
    );
  }
}
