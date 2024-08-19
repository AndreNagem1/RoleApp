import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/BottomSheets/reviews_bottom_sheet.dart';
import 'package:rolesp/Controllers/map_controller.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/dialogs/info_dialog.dart';
import 'package:rolesp/models/nearby_places_response.dart';
import 'package:rolesp/models/place_details_response.dart';
import 'package:rolesp/widgets/opening_hours_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common_utils.dart';
import '../../screens/events_screen/ui/events_background.dart';

class PlaceDetailsBottomSheet extends StatelessWidget {
  final PlaceInfo? place;
  final MapController mapController;
  final apiKey = 'AIzaSyDHqcABOOAoDDqR-UnJA5W7YwDVAa2t884';

  const PlaceDetailsBottomSheet(
      {required Key key, required this.place, required this.mapController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lisPhotos = place?.photos ?? [];

    return Container(
      height: 470,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.black87,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 200,
            child: CarouselSlider(
              items: lisPhotos
                  .map(
                    (photo) => CachedNetworkImage(
                      fit: BoxFit.fitWidth,
                      imageUrl: getPhotoUrl(photo.name ?? '', apiKey),
                      placeholder: (context, url) => const Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => CustomPaint(
                        painter: VectorBackgroundPainter(context),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 200,
                      child: Text(
                        place?.displayName?.text ?? '',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: 5),
                    Container(
                      alignment: Alignment.bottomCenter,
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
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
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
                const SizedBox(height: 10),
                Container(
                  height: 45,
                  alignment: Alignment.bottomLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        if (place?.goodForChildren == true) ...[
                          const WidgetSpan(
                            child: Icon(
                              Icons.family_restroom_outlined,
                              size: 15,
                            ),
                          ),
                          const TextSpan(text: ' Family'),
                          // Space after the icon
                        ],
                        if (place?.accessibilityOptions
                                ?.wheelchairAccessibleEntrance ==
                            true) ...[
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.accessible,
                                size: 15,
                              ),
                            ),
                          ),
                          const TextSpan(text: ' Acessibilidade'),
                          // Space after the icon
                        ],
                        if (place?.allowsDogs == true) ...[
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.pets_outlined,
                                size: 15,
                              ),
                            ),
                          ),
                          const TextSpan(text: ' Pet friendly'),
                          // Space after the icon
                        ],
                        if (place?.liveMusic == true) ...[
                          const WidgetSpan(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.music_note_outlined,
                                  size: 15,
                                ),
                                Text('Música ao vivo'),
                              ],
                            ),
                          ),
                        ],
                        if (place?.servesVegetarianFood == true) ...[
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.energy_savings_leaf_outlined,
                                    size: 15,
                                  ),
                                  Text(' Opções vegetarianas'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
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
                GestureDetector(
                  onTap: () {
                    showReviews(context, []);
                  },
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 15,
                        width: 85,
                        child: Image.asset(getAvaliationsImage(place?.rating)),
                      ),
                      Container(
                        height: 20,
                        width: 70,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Nota: ' + (place?.rating.toString() ?? '') + ' • ',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 110,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          getNumberOfAvaliations(place?.userRatingCount),
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    openOpenHoursDialog(
                        context,
                        place?.currentOpeningHours?.weekdayDescriptions ??
                            ['']);
                  },
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Row(
                        children: [
                          Text(
                            getPlaceStatus(place?.currentOpeningHours?.openNow),
                            style: GoogleFonts.roboto(color: Colors.white),
                          ),
                          Text(
                            getCurrentOpeningHour(place),
                            style: GoogleFonts.roboto(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 0.5,
                  width: double.infinity,
                  color: ColorsRoleSp.perfectPurple,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 40),
                    GestureDetector(
                      onTap: () {
                        _launchUrl(place, context);
                      },
                      child: Text(
                        'Site',
                        style: GoogleFonts.righteous(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        openAddInfoDialog(
                          context,
                          place?.formattedAddress ?? '',
                          place?.phoneNumber ?? 'Sem telefone',
                          place,
                          place?.currentOpeningHours!.weekdayDescriptions?[
                                  DateTime.now().weekday - 1] ??
                              '',
                        );
                      },
                      child: Text(
                        'Info',
                        style: GoogleFonts.righteous(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  String getCurrentOpeningHour(PlaceInfo? place) {
    final today = DateTime.now().weekday;
    final openingHour =
        place?.currentOpeningHours?.weekdayDescriptions?[today - 1];
    final startIndexOpeningHour = openingHour?.indexOf(':');
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

  String getNumberOfAvaliations(int? userRatingsTotal) {
    if (userRatingsTotal == null) {
      return 'Sem avaliações';
    }
    return '(${place?.userRatingCount} avaliações)';
  }

  String getAvaliationsImage(dynamic rating) {
    if (rating == null) {
      return 'assets/images/avaliations0.png';
    }
    if (rating <= 0.5) {
      return 'assets/images/avaliations1.png';
    }
    if (rating >= 0.5 && rating < 1.0) {
      return 'assets/images/avaliations2.png';
    }
    if (rating >= 1.0 && rating < 1.5) {
      return 'assets/images/avaliations3.png';
    }
    if (rating >= 1.5 && rating < 2.0) {
      return 'assets/images/avaliations4.png';
    }
    if (rating >= 2.0 && rating < 2.5) {
      return 'assets/images/avaliations5.png';
    }
    if (rating >= 2.5 && rating < 3.0) {
      return 'assets/images/avaliations6.png';
    }
    if (rating >= 3.0 && rating < 3.5) {
      return 'assets/images/avaliations7.png';
    }
    if (rating >= 3.5 && rating < 4.0) {
      return 'assets/images/avaliations8.png';
    }
    if (rating >= 4.0 && rating < 4.5) {
      return 'assets/images/avaliations9.png';
    }
    if (rating >= 4.5) {
      return 'assets/images/avaliations10.png';
    }

    return 'assets/images/avaliations0.png';
  }

  Future<void> _launchUrl(PlaceInfo? place, BuildContext context) async {
    final Uri _url = Uri.parse(place?.websiteUri ?? '');

    if (place?.websiteUri == null) {
      _showOverlay(context, text: 'Site indisponível :/');
    }

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void _showOverlay(BuildContext context, {required String text}) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: MediaQuery.of(context).size.width * 0.2,
        top: MediaQuery.of(context).size.height * 0.60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            child: Container(
              alignment: Alignment.center,
              color: Theme.of(context).colorScheme.onSurface,
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Text(
                text,
                style: GoogleFonts.righteous(
                    fontSize: 15, color: ColorsRoleSp.blackIcon),
              ),
            ),
          ),
        ),
      );
    });
    // inserting overlay entry
    overlayState.insert(overlayEntry);
    await Future.delayed(const Duration(seconds: 3))
        .whenComplete(() => overlayEntry.remove());
  }

  showReviews(BuildContext context, List<Reviews>? listReviews) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return ReviewsPageBottomSheet(
          listReviews: listReviews,
        );
      },
    );
  }

  openAddInfoDialog(BuildContext context, String address, String phone,
      PlaceInfo? placeInfo, String functioningHours) {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: SizedBox(
          height: 300,
          child: InfoDialog(
            vicinity: address,
            functioningHours: functioningHours,
            phone: phone,
            place: placeInfo,
          ),
        ),
      ),
    );
  }

  openOpenHoursDialog(BuildContext context, List<String> openingHours) {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: SizedBox(
          height: 315,
          child: OpeningHoursDialog(
            daysOpeningHours: openingHours,
          ),
        ),
      ),
    );
  }

  String getPhotoUrl(String photoName, String apiKey) {
    return 'https://places.googleapis.com/v1/' +
        photoName +
        '/media?key=' +
        apiKey +
        '&maxHeightPx=400';
  }
}
