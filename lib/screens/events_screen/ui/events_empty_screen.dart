import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/widgets/round_buttton.dart';

class EventsEmptyScreen extends StatelessWidget {
  const EventsEmptyScreen({super.key, required this.refreshEvents});

  final VoidCallback refreshEvents;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 400),
          const Text("Nenhum evento encontrado :/"),
          const Spacer(),
          RoundButton(
            height: 40,
            width: double.infinity,
            onPress: () {
              refreshEvents();
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
      ),
    );
  }
}
