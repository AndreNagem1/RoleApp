import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/models/favorite_place_info.dart';
import 'package:rolesp/screens/map_screen/domain/cubit/add_favorite_place_cubit.dart';

import '../domain/cubit/add_favorite_place_state.dart';

class AddFavoritePlaceDialog extends StatelessWidget {
  final FavoritePlaceInfo placeInfo;
  final VoidCallback onSuccess;

  const AddFavoritePlaceDialog({
    Key? key,
    required this.placeInfo,
    required this.onSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = AddFavoritePlaceCubit(InitialState());

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: BlocBuilder<AddFavoritePlaceCubit, AddFavoritePlaceDialogState>(
              bloc: cubit,
              builder: (context, state) {
                if (state is SuccessOnAddingFavoritePlace) {
                  Navigator.of(context).pop();
                  onSuccess();
                }
                if (state is LoadingState) {
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  );
                }
                return Column(
                  children: [
                    Container(
                      height: 45,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: ColorsRoleSp.perfectPurple,
                      ),
                      child: Text(
                        'Adicionar novo lugar como favorito',
                        style: GoogleFonts.righteous(
                          textStyle: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.righteous(
                              textStyle: const TextStyle(
                                fontSize: 15,
                                color: ColorsRoleSp.smoothLetter,
                              ),
                            ),
                            children: <TextSpan>[
                              const TextSpan(text: 'Deseja adicionar '),
                              TextSpan(
                                text: placeInfo.name,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const TextSpan(
                                  text: ' a sua lista de favoritos?'),
                            ],
                          ),
                        )),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: ColorsRoleSp.perfectPurple,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              border:
                                  Border.all(color: Colors.black38, width: 2)),
                          child: GestureDetector(
                            onTap: () {
                              cubit.savePlaceAsFavorite(
                                FavoritePlaceInfo(
                                  name: placeInfo.name,
                                  phoneNumber: placeInfo.phoneNumber,
                                  openHours: placeInfo.openHours,
                                  description: placeInfo.description,
                                  imageUrl: placeInfo.imageUrl,
                                ),
                              );
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Adicionar',
                                  style: GoogleFonts.righteous(
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        const SizedBox(width: 50),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Cancelar',
                              style: GoogleFonts.righteous(
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
