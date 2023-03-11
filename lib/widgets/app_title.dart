import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          "RoleSp",
          style: GoogleFonts.righteous(
            color: Colors.white,
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 30,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 6
                ..color = Colors.black,
            ),
          ),
        ),
        Text(
          "RoleSp",
          style: GoogleFonts.righteous(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
