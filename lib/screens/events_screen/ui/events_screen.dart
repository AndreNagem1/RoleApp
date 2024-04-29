import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/screens/events_screen/data/evento.dart';
import 'package:rolesp/screens/events_screen/ui/event_details_dialog.dart';
import 'package:rolesp/widgets/app_title.dart';

import '../../../widgets/loading.dart';
import '../domain/events_screen_cubit.dart';
import '../domain/events_screen_state.dart';
import 'events_empty_screen.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = EventsScreenCubit(LoadingState());
    cubit.loadEvents();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const AppTitle(),
        backgroundColor: const Color(0x44000000),
        elevation: 0.0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<EventsScreenCubit, EventsScreenState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is EmptyState) {
              return EventsEmptyScreen(refreshEvents: () {
                cubit.loadEvents();
              });
            }

            if (state is EventsLoadedSuccessState) {
              return ListView.builder(
                itemBuilder: (context, position) {
                  return Wrap(children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                openDetails(state.eventsList[position], context);
                              },
                              child: Container(
                                height: 200,
                                width: 320,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    width: 0.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 160,
                                      width: 100,
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            getDay(
                                                state.eventsList[position].data),
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                fontSize: 30,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            getMonth(
                                                state.eventsList[position].data),
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                fontSize: 18,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        Container(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          height: 100,
                                          width: 200,
                                          alignment: Alignment.centerLeft,
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            imageUrl:
                                                state.eventsList[position].imagem,
                                            placeholder: (context, url) =>
                                                const Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                            errorWidget: (context, url, error) =>
                                                Image.asset(
                                                    'assets/images/city.jpg'),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          state.eventsList[position].name,
                                          style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          state.eventsList[position].desciption,
                                          style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          state.eventsList[position].address,
                                          style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]);
                },
                itemCount: state.eventsList.length,
              );
            }

            return const LoadingScreen();
          }),
    );
  }
}

void openDetails(Event event, BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: SizedBox(
          height: 300,
          child: EventDetailsDialog(
            event: event,
          ),
        ),
      ),
    ),
  );
}

String getDay(Timestamp timestamp) {
  final date = timestamp.toDate();

  return date.day.toString();
}

String getMonth(Timestamp timestamp) {
  final date = timestamp.toDate();

  var monthName = '';

  switch (date.month) {
    case DateTime.january:
      monthName = 'Jan';
      break;
    case DateTime.february:
      monthName = 'Fev';
      break;
    case DateTime.march:
      monthName = 'Mar';
      break;
    case DateTime.april:
      monthName = 'Abr';
      break;
    case DateTime.may:
      monthName = 'Mai';
      break;
    case DateTime.june:
      monthName = 'Jun';
      break;
    case DateTime.july:
      monthName = 'Jul';
      break;
    case DateTime.august:
      monthName = 'Ago';
      break;
    case DateTime.september:
      monthName = 'Set';
      break;
    case DateTime.october:
      monthName = 'Out';
      break;
    case DateTime.november:
      monthName = 'Nov';
      break;
    case DateTime.december:
      monthName = 'Dez';
  }
  return monthName;
}
