import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Controllers/map_controller.dart';
import 'package:rolesp/models/favorite_place_info.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/screens/map_screen/ui/add_favorite_place_dialog.dart';

import '../mock/NearbyPlacesMocked.dart';

class PlacesListItem extends StatelessWidget {
  final Results? results;
  final MapController mapController;
  final VoidCallback onTap;
  final apiKey = 'AIzaSyAeFQsZFQ1uTHm53Brfxu4AH3R8JBHvj9M';

  const PlacesListItem({
    Key? key,
    required this.results,
    required this.onTap,
    required this.mapController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUrl = '';

    if (results?.photos?[0] != null) {
      imageUrl =
          'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=' +
              results!.photos![0].photoReference! +
              '&key=' +
              apiKey;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 350,
        height: 350,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
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
                fit: BoxFit.fill,
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
                          results?.name ?? '',
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
                                name: results?.name ?? '',
                                phoneNumber: results?.phone ?? '',
                                openHours: NearbyPlacesMocked()
                                        .mockedOpeningHours
                                        .weekdayText?[1] ??
                                    '',
                                description: results?.types?.first ?? ''),
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
                                      fontSize: 16,
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
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      getDescription(results?.types ?? ['Restautante']),
                      style: GoogleFonts.acme(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 100,
                          child: Image.asset('assets/images/avaliations9.png'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        getPlaceStatus(results?.openingHours?.openNow),
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        getFunctionHours(results?.openingHours),
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).colorScheme.onSurface,
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
                                  results?.geometry?.location?.lat ?? 0.0,
                                  results?.geometry?.location?.lng ?? 0.0,
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
                                    child: CircularProgressIndicator()),
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

  String getFunctionHours(OpeningHours? openingHours) {
    String? status;
    final weekDayIndex = DateTime.now().weekday - 1;

    status = results?.openingHours?.weekdayText?[weekDayIndex];
    final startIndex = status?.indexOf(':');
    if (startIndex != -1) {
      status = status?.substring(startIndex!);
    }
    status = status?.replaceAll('Closed', '');
    return status ??= '';
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
