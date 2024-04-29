import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';

class HourItem extends StatelessWidget {
  final String hour;
  final bool showBottomDivider;

  const HourItem(
      {Key? key, required this.hour,  this.showBottomDivider = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final referenceIndex = hour.indexOf(':') + 1;

    return Column(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                hour.substring(0, referenceIndex),
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                hour.substring(referenceIndex),
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showBottomDivider)
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
