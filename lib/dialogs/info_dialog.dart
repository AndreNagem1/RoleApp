import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/models/nearby_places_response.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/widgets/opening_hours_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/hour_item.dart';

class InfoDialog extends StatelessWidget {
  final String vicinity;
  final String phone;
  final PlaceInfo? place;
  final String functioningHours;

  const InfoDialog({
    Key? key,
    required this.vicinity,
    required this.phone,
    required this.functioningHours,
    this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              height: 45,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: ColorsRoleSp.perfectPurple,
              ),
              child: Text(
                'Sobre',
                style: GoogleFonts.righteous(
                  textStyle: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  const SizedBox(width: 30),
                  SizedBox(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'Endereço',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          vicinity,
                          maxLines: 2,
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.map_outlined,
                    color: ColorsRoleSp.perfectPurple,
                  ),
                  const SizedBox(width: 30),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, top: 2.0, right: 8.0, bottom: 2.0),
              child: Container(
                color: ColorsRoleSp.perfectPurple,
                height: 0.5,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 2),
            GestureDetector(
              onTap: () {
                if (place?.currentOpeningHours?.weekdayDescriptions != null) {
                  openOpenHoursDialog(context,
                      place?.currentOpeningHours?.weekdayDescriptions ?? ['']);
                }
              },
              child: SizedBox(
                height: 70,
                child: Row(
                  children: [
                    const SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          'Horário',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          functioningHours
                              .replaceAll('Monday', 'Seg.')
                              .replaceAll('Closed', 'Fechado'),
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward,
                      color: ColorsRoleSp.perfectPurple,
                    ),
                    const SizedBox(width: 30),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, top: 2.0, right: 8.0, bottom: 2.0),
              child: Container(
                color: ColorsRoleSp.perfectPurple,
                height: 0.5,
                width: double.infinity,
              ),
            ),
            GestureDetector(
              onTap: () {
                makePhoneCall();
              },
              child: SizedBox(
                height: 70,
                child: Row(
                  children: [
                    const SizedBox(width: 30),
                    SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            'Ligar',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            phone,
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.phone,
                      color: ColorsRoleSp.perfectPurple,
                    ),
                    const SizedBox(width: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  makePhoneCall() {
    launchUrl(
      Uri(
        scheme: 'tel',
        path: phone.removeAllWhitespace,
      ),
    );
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

  openOpenHoursDialog(BuildContext context, List<String> openingHours) {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: SizedBox(
          height: 300,
          child: OpeningHoursDialog(
            daysOpeningHours: openingHours,
          ),
        ),
      ),
    );
  }
}
