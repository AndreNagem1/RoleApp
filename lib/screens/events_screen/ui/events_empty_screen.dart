import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/widgets/round_buttton.dart';

class EventsEmptyScreen extends StatelessWidget {
  const EventsEmptyScreen({super.key, required this.refreshEvents});

  final VoidCallback refreshEvents;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        const Text("Nem evento encontrado :/"),
        const Spacer(),
        RoundButton(
          height: 40,
          width: 110,
          onPress: () {
            refreshEvents;
          },
          text: 'Procurar novos eventos',
          backGroundColor: Theme.of(context).colorScheme.onSurface,
          borderColor: Theme.of(context).colorScheme.onSurface,
          font: GoogleFonts.righteous(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
