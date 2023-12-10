import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/models/favorite_place_info.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/screens/favorites_screen/ui/add_new_number_dialog.dart';
import 'package:rolesp/widgets/Swipeable.dart';
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
                    cubit,
                  );
                  return sweapable;
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

  Widget favoriteListItem(
    BuildContext context,
    FavoritePlaceInfo placeInfo,
    bool isOpen,
    int position,
    int selectedItemToDelete,
    FavoriteScreenCubit cubit,
  ) {
    final phoneIsEmpty = placeInfo.phoneNumber.isEmpty;

    var iconColor = Theme.of(context).colorScheme.onSurface;

    if (phoneIsEmpty == true) {
      iconColor = Theme.of(context).colorScheme.secondary;
    }

    return Padding(
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
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            SizedBox(
              height: 100,
              width: 130,
              child: Image.asset('assets/images/blackHorse.jpg'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  placeInfo.name,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
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
                      ' ' + placeInfo.openHours,
                      style: GoogleFonts.roboto(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    )
                  ],
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
                  cubit.deleteItem(placeInfo.name, position);
                },
                child: Container(
                  height: double.infinity,
                  width: 80,
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
    );
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
