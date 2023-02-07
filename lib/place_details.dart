import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/ColorsRoleSp.dart';
import 'package:rolesp/reviews_page.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetails extends StatelessWidget {
  final String? nome;
  final String? image;
  final Uri _url = Uri.parse('https://theblackhorse.com.br/');

  PlaceDetails({required Key key, this.nome, this.image}) : super(key: key);

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
                        'Black Horse',
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
                        child: Image.asset(
                          'assets/images/avaliations.png',
                        ),
                      ),
                      const SizedBox(width: 2),
                      Container(
                        height: 20,
                        width: 100,
                        alignment: Alignment.center,
                        child: Text(
                          '(182 avaliações)',
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
                    Text(
                      'Info',
                      style: GoogleFonts.righteous(
                        color: Colors.white,
                        fontSize: 20,
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
        return const ReviewsPage();
      },
    );
  }
}
