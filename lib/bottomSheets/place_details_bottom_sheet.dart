import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/BottomSheets/reviews_bottom_sheet.dart';
import 'package:rolesp/Controllers/map_controller.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/dialogs/info_dialog.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetailsBottomSheet extends StatelessWidget {
  final Results results;
  final MapController mapController;
  final apiKey = 'AIzaSyAeFQsZFQ1uTHm53Brfxu4AH3R8JBHvj9M';

  const PlaceDetailsBottomSheet(
      {required Key key, required this.results, required this.mapController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUrl = '';
    if (results.photos?[0] != null) {
      imageUrl =
          'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=' +
              results.photos![0].photoReference! +
              '&key=' +
              apiKey;
    }
    return Container(
      height: 400,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.black54,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 200,
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 150,
                      child: Text(
                        results.name!,
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 70,
                      child: FutureBuilder<Position>(
                          future: mapController.getUserPosition(),
                          builder: (BuildContext context,
                              AsyncSnapshot<Position> snapshot) {
                            if (snapshot.hasData) {
                              final distance = calculateDistance(
                                snapshot.data?.latitude ?? 0.0,
                                snapshot.data?.longitude ?? 0.0,
                                results.geometry?.location?.lat ?? 0.0,
                                results.geometry?.location?.lng ?? 0.0,
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
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    getDescription(results.types ?? ['Restautante']),
                    style: GoogleFonts.acme(
                      textStyle:
                          const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    showReviews(context);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 100,
                        child: Image.asset(getAvaliationsImage(results.rating)),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 20,
                        width: 70,
                        alignment: Alignment.center,
                        child: Text(
                          'Nota: ' + results.rating.toString() + ' • ',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: ColorsRoleSp.whiteLetter,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 100,
                        alignment: Alignment.center,
                        child: Text(
                          getNumberOfAvaliations(results.userRatingsTotal),
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
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      getPlaceStatus(results.openingHours?.openNow),
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                    Text(
                      getFunctionHours(results.openingHours),
                      style: GoogleFonts.roboto(color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  height: 0.5,
                  width: double.infinity,
                  color: ColorsRoleSp.perfectPurple,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 40),
                    GestureDetector(
                      onTap: () {
                        _launchUrl(results, context);
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
                          results.vicinity ?? '',
                          results.phone ?? 'Sem telefone',
                          results,
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

  String getFunctionHours(OpeningHours? openingHours) {
    String? status;
    final weekDayIndex = DateTime.now().weekday - 1;

    status = results.openingHours?.daysOpeningHours?[weekDayIndex];
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
    return '(${results.userRatingsTotal} avaliações)';
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

  Future<void> _launchUrl(Results result, BuildContext context) async {
    final Uri _url = Uri.parse(result.website ?? '');

    if (result.website == null) {
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
              color: ColorsRoleSp.whiteLetter,
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
    overlayState!.insert(overlayEntry);
    await Future.delayed(const Duration(seconds: 3))
        .whenComplete(() => overlayEntry.remove());
  }

  showReviews(BuildContext context) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return const ReviewsPageBottomSheet();
      },
    );
  }

  openAddInfoDialog(
      BuildContext context, String address, String phone, Results? results) {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: SizedBox(
          height: 300,
          child: InfoDialog(
            vicinity: address,
            phone: phone,
            results: results,
          ),
        ),
      ),
    );
  }
}
