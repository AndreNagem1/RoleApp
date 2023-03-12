import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoDialog extends StatelessWidget {
  final String vicinity;
  final String phone;
  final Results? results;

  const InfoDialog({
    Key? key,
    required this.vicinity,
    required this.phone,
    this.results,
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
              height: 70,
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
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.map_outlined),
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
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  const SizedBox(width: 30),
                  SizedBox(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
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
                          getFunctionHours(results),
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward),
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
            SizedBox(
              height: 70,
              child: GestureDetector(
                onTap: () {
                  makePhoneCall();
                },
                child: Row(
                  children: [
                    const SizedBox(width: 30),
                    SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.phone),
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

  String getFunctionHours(Results? result) {
    String? status;
    status = getPlaceStatus(result?.openingHours?.openNow) + ' ';

    final weekDayIndex = DateTime.now().weekday - 1;
    final startIndex =
        results?.openingHours?.daysOpeningHours?[weekDayIndex].indexOf(':');
    status += results?.openingHours?.daysOpeningHours?[weekDayIndex]
            .substring(startIndex ?? 0) ??
        '';

    status = status.replaceAll('Closed', '');
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
}
