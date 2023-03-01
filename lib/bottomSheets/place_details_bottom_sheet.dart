import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/BottomSheets/reviews_bottom_sheet.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/dialogs/info_dialog.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetailsBottomSheet extends StatelessWidget {
  final Results results;
  final Uri _url = Uri.parse('https://theblackhorse.com.br/');

  PlaceDetailsBottomSheet({
    required Key key,
    required this.results,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Image.asset(
            'assets/images/blackHorse.jpg',
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
                    Container(
                      width: 20,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.arrow_upward_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 2),
                    SizedBox(
                      width: 35,
                      child: Text(
                        '2 Km',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
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
                    'Pratos, homburguer, cerveja e drinks',
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
                      const SizedBox(width: 2),
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
                      'Aberto -',
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                    Text(
                      '18h - 22h30',
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
                  children: [
                    const SizedBox(width: 40),
                    GestureDetector(
                      onTap: () {
                        _launchUrl();
                      },
                      child: Text(
                        'Menu',
                        style: GoogleFonts.righteous(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        openAddReviewDialog(context);
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

  String getNumberOfAvaliations(int? userRatingsTotal) {
    if (userRatingsTotal == null) {
      return 'Sem avaliações';
    }
    return '(${results.userRatingsTotal} avaliações)';
  }

  String getAvaliationsImage(dynamic rating) {
    print("MEU PRINT" + rating.toString());
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

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
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

  openAddReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const Center(
        child: SizedBox(
          height: 300,
          child: InfoDialog(),
        ),
      ),
    );
  }
}
