import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/models/favorite_place_info.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/screens/favorites_screen/ui/add_new_number_dialog.dart';
import 'package:rolesp/screens/favorites_screen/ui/delete_number_dialog.dart';
import 'package:rolesp/widgets/Swipeable.dart';
import 'package:rolesp/widgets/app_title.dart';
import 'package:vibration/vibration.dart';

import '../../events_screen/ui/events_background.dart';
import '../domain/favorite_screen_cubit.dart';
import '../domain/favorite_screen_state.dart';
import 'favorites_loading_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  final apiKey = 'AIzaSyDHqcABOOAoDDqR-UnJA5W7YwDVAa2t884';

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
      body: CustomPaint(
        size: const Size(double.infinity, double.infinity),
        painter: VectorBackgroundPainter(context),
        child: BlocBuilder<FavoriteScreenCubit, FavoritsScreenState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is UpdatedPhoneSuccess) {
                updatedPhoneSuccessMessage(context);
                cubit.loadFavoritesPlaces();
              }
              if (state is EmptyListState) {
                return Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Você não tem nenhum lugar salvo como favorito, conheça lugares especiais para salva-los aqui :)',
                      style: GoogleFonts.roboto(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              if (state is SuccessState) {
                return ListView.separated(
                  separatorBuilder: (context, position) {
                    return const SizedBox(height: 15);
                  },
                  itemBuilder: (context, position) {
                    var isOpen = true;

                    if (position == 3 || position == 6 || position == 7) {
                      isOpen = false;
                    }

                    final sweapable = Sweapeble();

                    sweapable.child = favoriteListItem(
                        context,
                        state.listFavoritePlaces[position],
                        isOpen,
                        position,
                        state.selectedItemToDelete,
                        cubit);
                    return sweapable;
                  },
                  itemCount: state.listFavoritePlaces.length,
                );
              }

              return const FavoritesLoadingScreen();
            }),
      ),
    );
  }

  Widget favoriteListItem(
      BuildContext context,
      FavoritePlaceInfo placeInfo,
      bool isOpen,
      int position,
      int selectedItemToDelete,
      FavoriteScreenCubit cubit) {
    final phoneIsEmpty = placeInfo.phoneNumber.isEmpty;

    var iconColor = Theme.of(context).colorScheme.onSurface;

    if (phoneIsEmpty == true) {
      iconColor = Theme.of(context).colorScheme.secondary;
    }

    var titleFontSize = 15.0;

    if (placeInfo.name.length > 18) {
      titleFontSize = 12.0;
    }

    var title = placeInfo.name;

    if (placeInfo.name.length > 18) {
      title = placeInfo.name.substring(0, 17) + '...';
    }

    var openHoursFontSize = 14.0;

    if (placeInfo.openHours.length > 15) {
      openHoursFontSize = 10.0;
    }

    final imageUrl = 'https://places.googleapis.com/v1/' +
        placeInfo.imageUrl +
        '/media?key=' +
        apiKey +
        '&maxHeightPx=400';

    return GestureDetector(
      onTap: () {
        cubit.selectItemToBeDeleted(-1);
      },
      onLongPress: () {
        cubit.selectItemToBeDeleted(position);
        vibratePhone();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Container(
          height: 100,
          clipBehavior: Clip.hardEdge,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              SizedBox(
                height: 100,
                width: 130,
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  imageUrl: imageUrl,
                  placeholder: (context, url) => const Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => CustomPaint(
                    painter: VectorBackgroundPainter(context),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: titleFontSize,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      children: [
                        if (isOpen == true) ...[
                          TextSpan(
                            text: 'Aberto',
                            style: GoogleFonts.roboto(
                              color: Colors.green,
                            ),
                          ),
                        ],
                        if (isOpen == false) ...[
                          TextSpan(
                            text: 'Fechado',
                            style: GoogleFonts.roboto(
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                        TextSpan(
                          text: ' ' + placeInfo.openHours,
                          style: GoogleFonts.roboto(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: openHoursFontSize,
                          ),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    placeInfo.description,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (position != selectedItemToDelete)
                GestureDetector(
                  onTap: () {
                    onPhoneTap(
                      placeInfo,
                      cubit,
                      context,
                    );
                  },
                  child: Row(
                    children: [
                      if (phoneIsEmpty == true)
                        Icon(
                          Icons.add,
                          size: 25,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      Icon(
                        Icons.phone,
                        size: 33,
                        color: iconColor,
                      ),
                    ],
                  ),
                ),
              if (position != selectedItemToDelete) const SizedBox(width: 20),
              if (position == selectedItemToDelete)
                GestureDetector(
                  onTap: () {
                    openDeleteNumber(context, cubit, placeInfo, position);
                  },
                  child: Container(
                    height: double.infinity,
                    width: 60,
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      size: 33,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void vibratePhone() async {
    if (await Vibration.hasCustomVibrationsSupport() == true) {
      Vibration.vibrate(duration: 60);
    } else {
      Vibration.vibrate();
      await Future.delayed(const Duration(milliseconds: 60));
      Vibration.vibrate();
    }
  }

  void onPhoneTap(FavoritePlaceInfo placeInfo, FavoriteScreenCubit cubit,
      BuildContext context) {
    if (placeInfo.phoneNumber.isNotEmpty == true) {
      cubit.openWhatsApp(placeInfo.phoneNumber);
    } else {
      openAddNewNumber(context, cubit, placeInfo);
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

  openDeleteNumber(BuildContext context, FavoriteScreenCubit cubit,
      FavoritePlaceInfo placeInfo, int index) {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: SizedBox(
            height: 250,
            child: DeleteNumberDialog(
              onDeleteNumber: () {
                cubit.deleteItem(placeInfo.name, index);
              },
            ),
          ),
        ),
      ),
    );
  }

  openAddNewNumber(BuildContext context, FavoriteScreenCubit cubit,
      FavoritePlaceInfo placeInfo) {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: SizedBox(
            height: 250,
            child: AddNewNumberDialog(
              onAddNumber: (phoneNumber) {
                cubit.openAddNewNumber(placeInfo, phoneNumber);
              },
            ),
          ),
        ),
      ),
    );
  }

  updatedPhoneSuccessMessage(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Telephone adicionado com sucesso",
          style: GoogleFonts.righteous(
            textStyle: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ),
      ));
    });
  }
}
