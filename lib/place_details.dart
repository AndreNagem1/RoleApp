import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/reviews_page.dart';
import 'package:rolesp/round_buttton.dart';

class PlaceDetails extends StatelessWidget {
  final String? nome;
  final String? image;

  const PlaceDetails({required Key key, this.nome, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.7,
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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundButton(
                    height: 40,
                    width: 110,
                    onPress: () {
                      showReviews(context);
                    },
                    text: 'Reviews',
                    backGroundColor: const Color.fromARGB(176, 255, 255, 255),
                    borderColor: Colors.black,
                    font: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 35,
                      width: 120,
                      child: Image.asset(
                        'assets/images/avaliations.png',
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: SizedBox(
              height: 30,
              width: double.infinity,
              child: Text(
                'Black Horse',
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0),
            child: SizedBox(
              height: 45,
              width: double.infinity,
              child: Text(
                'Bar, Rock, Cerveja. Hamburguers e pratos especiais.',
                style: GoogleFonts.acme(
                  textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RoundButton(
              height: 70,
              width: double.infinity,
              onPress: () => Navigator.pop(context),
              text: 'Vamos',
              backGroundColor: Colors.white,
              borderColor: Colors.transparent,
              font: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
