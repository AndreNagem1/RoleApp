import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/models/favorite_place_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'favorite_screen_state.dart';

class FavoriteScreenCubit extends Cubit<FavoritsScreenState> {
  final db = FirebaseFirestore.instance;
  final favoritePlaceInfoList = <FavoritePlaceInfo>[];

  FavoriteScreenCubit(super.initialState);

  void loadFavoritesPlaces() async {
    final favoritePlaceInfoList = <FavoritePlaceInfo>[];

    await db.collection('favorites').get().then((event) {
      for (var doc in event.docs) {
        final placeInfo = FavoritePlaceInfo(
            name: doc['name'],
            description: doc['description'],
            phoneNumber: doc['phoneNumber'],
            openHours: doc['openHours']);

        favoritePlaceInfoList.add(placeInfo);
      }
    });

    if (favoritePlaceInfoList.isEmpty) {
      emit(EmptyListState());
    } else {
      emit(SuccessState(favoritePlaceInfoList, false));
    }
  }

  void openWhatsApp(String phone) async {
    FocusManager.instance.primaryFocus?.unfocus();

    var whatsappUrl = "whatsapp://send?phone=${'+55' + phone}";
    try {
      launchUrl(Uri.parse(whatsappUrl));
    } catch (e) {
      print('Failed to open whatsapp');
    }
  }

  void openAddNewNumber() async {
    emit(SuccessState(favoritePlaceInfoList, true));
  }
}
