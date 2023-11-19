import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/screens/favorites_screen/ui/add_new_number_dialog.dart';
import 'package:rolesp/widgets/app_title.dart';

import '../domain/favorite_screen_cubit.dart';
import '../domain/favorite_screen_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = FavoriteScreenCubit(LoadingState());
    cubit.loadFavoritesPlaces();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const AppTitle(),
        backgroundColor: const Color(0x44000000),
        elevation: 0.0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<FavoriteScreenCubit, FavoritsScreenState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is SuccessState) {
              return ListView.builder(
                itemBuilder: (context, position) {
                  final isOpen =
                      state.listFavoritePlaces[position].openingHours?.openNow;

                  final phoneIsEmpty =
                      state.listFavoritePlaces[position].phone?.isEmpty;

                  var iconColor = Theme.of(context).colorScheme.onSurface;

                  if (phoneIsEmpty == true) {
                    iconColor = Theme.of(context).colorScheme.secondary;
                  }

                  return Wrap(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Container(
                            height: 100,
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
                              children: [
                                const SizedBox(width: 10),
                                SizedBox(
                                  height: 100,
                                  width: 130,
                                  child: Image.asset(
                                      'assets/images/blackHorse.jpg'),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      state.listFavoritePlaces[position].name ??
                                          '',
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        if (isOpen == true)
                                          Text(
                                            'Aberto',
                                            style: GoogleFonts.roboto(
                                              color: Colors.green,
                                            ),
                                          ),
                                        if (isOpen == false)
                                          Text(
                                            'Fechado',
                                            style: GoogleFonts.roboto(
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                        Text(
                                          ' ' +
                                              getFunctionHours(
                                                  state
                                                      .listFavoritePlaces[
                                                          position]
                                                      .openingHours,
                                                  state.listFavoritePlaces[
                                                      position]),
                                          style: GoogleFonts.roboto(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      state.listFavoritePlaces[position].types
                                              ?.first ??
                                          '',
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    onPhoneTap(
                                        state
                                            .listFavoritePlaces[position].phone,
                                        cubit,
                                        context);
                                  },
                                  child: Row(
                                    children: [
                                      if (phoneIsEmpty == true)
                                        Icon(
                                          Icons.add,
                                          size: 25,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      Icon(
                                        Icons.phone,
                                        size: 33,
                                        color: iconColor,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]);
                },
                itemCount: state.listFavoritePlaces.length,
              );
            }

            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            );
          }),
    );
  }

  void onPhoneTap(
      String? phone, FavoriteScreenCubit cubit, BuildContext context) {
    if (phone?.isNotEmpty == true) {
      cubit.openWhatsApp(phone!);
    } else {
      openAddNewNumber(context);
    }
  }

  String getFunctionHours(OpeningHours? openingHours, Results? results) {
    String? status;
    final weekDayIndex = DateTime.now().weekday - 1;

    status = results?.openingHours?.weekdayText?[weekDayIndex];
    final startIndex = status?.indexOf(':');
    if (startIndex != -1) {
      status = status?.substring(startIndex!);
    }
    status = status?.replaceAll('Closed', '');
    return status ??= '';
  }

  openAddNewNumber(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 30.0),
          child: SizedBox(
            height: 200,
            child: AddNewNumberDialog(),
          ),
        ),
      ),
    );
  }
}
