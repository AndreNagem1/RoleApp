import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/widgets/app_title.dart';

import '../../../widgets/loading.dart';
import '../domain/favorite_screen_cubit.dart';
import '../domain/favorite_screen_state.dart';

class FavoriteScreen extends StatelessWidget {
  final NearbyPlacesResponse? response;

  const FavoriteScreen({Key? key, required this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = FavoriteScreenCubit(LoadingState());

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
                                child:
                                    Image.asset('assets/images/blackHorse.jpg'),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 20,
                                    width: 200,
                                    child: Text(
                                      response?.results?[position].name ?? '',
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
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        getPlaceStatus(response
                                            ?.results?[position]
                                            .openingHours
                                            ?.openNow),
                                        style: GoogleFonts.roboto(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                      ),
                                      Text(
                                        getFunctionHours(
                                            response?.results?[position]
                                                .openingHours,
                                            response?.results?[position]),
                                        style: GoogleFonts.roboto(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]);
              },
              itemCount: response?.results?.length,
            );
          }),
    );
  }

  String getPlaceStatus(bool? open) {
    var status = 'Aberto ';
    if (open == null) {
      status = 'Sem informação ';
    }
    if (open == false) {
      status = 'Fechado ';
    }
    if (status.contains('')) {}
    return status;
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
}
