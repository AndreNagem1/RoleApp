import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/widgets/app_title.dart';

import '../../../widgets/loading.dart';
import '../../favorites_screen/domain/favorite_screen_cubit.dart';
import '../../favorites_screen/domain/favorite_screen_state.dart';
import 'events_empty_screen.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = FavoriteScreenCubit(LoadingState());
    cubit.loadEvents();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const AppTitle(),
        backgroundColor: const Color(0x44000000),
        elevation: 0.0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<FavoriteScreenCubit, EventsScreenState>(
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.onSurface,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 150,
                                  width: 100,
                                  color: Theme.of(context).colorScheme.surface,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.listEvents[position].startDate
                                                ?.substring(0, 2) ??
                                            '',
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
                                        'Out',
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
                                const SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Container(
                                      color: ColorsRoleSp.white,
                                      height: 100,
                                      width: 200,
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                          state.listEvents[position].url ?? ""),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      state.listEvents[position].name ?? "",
                                      style: GoogleFonts.roboto(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      state.listEvents[position].description ??
                                          "",
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      state.listEvents[position].location ?? "",
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]);
                },
                itemCount: state.listEvents.length,
              );
            }

            return const LoadingScreen();
          }),
    );
  }
}
