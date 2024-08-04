import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Controllers/map_controller.dart';
import 'package:rolesp/models/favorite_place_info.dart';
import 'package:rolesp/models/nearby_places_response.dart';
import 'package:rolesp/screens/map_screen/ui/add_favorite_place_dialog.dart';

import '../common_utils.dart';

class PlacesListItem extends StatelessWidget {
  final PlaceInfo? place;
  final MapController mapController;
  final VoidCallback onTap;
  final apiKey = 'AIzaSyDHqcABOOAoDDqR-UnJA5W7YwDVAa2t884';

  const PlacesListItem({
    Key? key,
    required this.place,
    required this.onTap,
    required this.mapController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUrl = '';

    if (place?.photos?[0] != null) {
      imageUrl = 'https://places.googleapis.com/v1/' +
          place!.photos![0].name! +
          '/media?key=' +
          apiKey +
          '&maxHeightPx=400';
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 350,
        height: 375,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface,
            width: 0.5,
          ),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 150,
              width: double.infinity,
              child: CachedNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: imageUrl,
                placeholder: (context, url) => const Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/blackHorse.jpg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 200,
                        child: Text(
                          place?.displayName?.text ?? '',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          openFavoritePlaceDialog(
                            context,
                            FavoritePlaceInfo(
                                name: place?.displayName?.text ?? '',
                                phoneNumber: place?.phoneNumber ?? '',
                                openHours: getCurrentOpeningHour(place),
                                description: place?.phoneNumber ?? ''),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSurface,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 5),
                            child: Row(
                              children: [
                                Text(
                                  'Favoritar',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Theme.of(context).colorScheme.surface,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 15,
                        width: 75,
                        child:
                            Image.asset(getPriceLevel(place?.priceLevel ?? '')),
                      ),
                      if (place?.priceLevel == null)
                        Text(
                          ' • Sem informação de preço',
                          style: GoogleFonts.roboto(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 11,
                          ),
                        ),
                      if (place?.priceLevel?.contains('FREE') == true)
                        Text(
                          ' • Sem valor associado',
                          style: GoogleFonts.roboto(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 11,
                          ),
                        )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 15,
                        width: 75,
                        child: Image.asset(getRating(place?.rating ?? 0)),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        ' • ' +
                            (place?.userRatingCount?.toString() ?? '0') +
                            ' avaliações',
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        getPlaceStatus(
                            place?.currentOpeningHours?.openNow ?? true),
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      if (place?.currentOpeningHours?.openNow ?? true)
                        Text(
                          getCurrentOpeningHour(place),
                          style: GoogleFonts.roboto(
                            color: Theme.of(context).colorScheme.onSurface,
                            textStyle: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      const Spacer(),
                      SizedBox(
                        height: 20,
                        width: 70,
                        child: FutureBuilder<Position>(
                            future: mapController.getUserPosition(),
                            builder: (BuildContext context,
                                AsyncSnapshot<Position> snapshot) {
                              if (snapshot.hasData) {
                                final distance = calculateDistance(
                                  snapshot.data?.latitude ?? 0.0,
                                  snapshot.data?.longitude ?? 0.0,
                                  place?.location?.latitude ?? 0.0,
                                  place?.location?.longitude ?? 0.0,
                                );

                                return Text(
                                  distance.toString().substring(0, 4) + ' Km',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }
                              return const Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  openFavoritePlaceDialog(BuildContext context, FavoritePlaceInfo placeInfo) {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: SizedBox(
            height: 220,
            child: AddFavoritePlaceDialog(
              placeInfo: placeInfo,
              onSuccess: () {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Lugar adicionado aos favoritos",
                      style: GoogleFonts.righteous(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ));
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  String getCurrentOpeningHour(PlaceInfo? place) {
    final today = DateTime.now().weekday;
    final openingHour =
        place?.currentOpeningHours?.weekdayDescriptions?[today - 1];
    var startIndexOpeningHour = openingHour?.indexOf(':');

    if (startIndexOpeningHour == -1) {
      startIndexOpeningHour = 0;
    }
    final openingHourFormatted =
        openingHour?.substring(startIndexOpeningHour ?? 0);

    return openingHourFormatted ?? '';
  }

  String getPlaceStatus(bool? open) {
    var status = 'Aberto ';
    if (open == null) {
      status = 'Sem informação ';
    }
    if (open == false) {
      status = 'Fechado ';
    }
    if (status.contains('')) {}
    return status;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  String getDescription(List<String> types) {
    var description = '';
    var index = 0;
    while (index < 3) {
      var type = types[index];
      type = translate(type);
      var separator = ' |';
      if (index == 2) {
        separator = '';
      }
      description += ' ' + type + separator;
      index++;
    }
    return description;
  }

  String translate(String type) {
    if (type.contains('meal')) {
      return 'Delivery';
    }
    if (type.contains('food')) {
      return 'Comida';
    }
    if (type.contains('bakery')) {
      return 'Padaria';
    }
    if (type.contains('cafe')) {
      return 'Café';
    }
    if (type.contains('bar')) {
      return 'Bar';
    }
    if (type.contains('restaurant')) {
      return 'Restaurante';
    }
    if (type.contains('health')) {
      return 'Saudável';
    }
    if (type.contains('point')) {
      return 'Lazer';
    }
    if (type.contains('store')) {
      return 'Loja';
    }
    return type;
  }
}
