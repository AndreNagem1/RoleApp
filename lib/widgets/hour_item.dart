import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';

class HourItem extends StatelessWidget {
  final String hour;

  const HourItem({Key? key, required this.hour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            hour,
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
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
        const SizedBox(height: 10),
      ],
    );
  }
}
