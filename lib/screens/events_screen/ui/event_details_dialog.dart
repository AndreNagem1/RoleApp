import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/screens/events_screen/data/evento.dart';

class EventDetailsDialog extends StatelessWidget {
  final Event event;

  const EventDetailsDialog({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          border: Border.all(
            color: Theme
                .of(context)
                .colorScheme
                .onSurface,
            width: 0.5,
          ),
          color: Theme
              .of(context)
              .colorScheme
              .surface,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Container(
                  color:  Theme
                      .of(context)
                      .colorScheme
                      .surface,
                  height: 105,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    imageUrl: event.imagem,
                    placeholder: (context, url) =>
                    const Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/images/city.jpg'),
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    SizedBox(
                      height: 15,
                      width: double.infinity,
                      child: Text(
                        event.name,
                        style: GoogleFonts.righteous(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 15,
                      width: double.infinity,
                      child: Text(
                        getDateString(event.data.toDate()),
                        style: GoogleFonts.righteous(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 15,
                      width: double.infinity,
                      child: Text(
                        event.longDescription,
                        style: GoogleFonts.righteous(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String getDateString(DateTime date) {
  return date.day.toString() + '/' + date.month.toString() + '/' +
      date.year.toString() + ' (${getWeekDay(date.weekday)})';
}


String getWeekDay(int weekday) {
  if (weekday == 1) {
    return 'segunda-feira';
  }
  if (weekday == 2) {
    return 'terça-feira';
  }
  if (weekday == 3) {
    return 'quarta-feira';
  }
  if (weekday == 4) {
    return 'quinta-feira';
  }
  if (weekday == 5) {
    return 'sexta-feira';
  }
  if (weekday == 5) {
    return 'sábado';
  }

  return 'domingo';
}