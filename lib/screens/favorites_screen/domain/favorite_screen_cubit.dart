import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/models/favorite_place_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'favorite_screen_state.dart';

class FavoriteScreenCubit extends Cubit<FavoritsScreenState> {
  final db = FirebaseFirestore.instance;
  var currentPlaceList = <FavoritePlaceInfo>[];
  var selectedItemToDelete = -1;

  FavoriteScreenCubit(super.initialState);

  void loadFavoritesPlaces() async {
    final favoritePlaceInfoList = <FavoritePlaceInfo>[];

    await db.collection('favorites').get().then((event) {
      for (var doc in event.docs) {
        final placeInfo = FavoritePlaceInfo(
            name: doc['name'],
            description: doc['description'],
            phoneNumber: doc['phoneNumber'],
            openHours: doc['openHours'],
            imageUrl: doc['imageUrl'] ?? ''
        );

        favoritePlaceInfoList.add(placeInfo);
      }
    });

    if (favoritePlaceInfoList.isEmpty) {
      emit(EmptyListState());
    } else {
      currentPlaceList = favoritePlaceInfoList;
      emit(SuccessState(favoritePlaceInfoList, false, -1));
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

  void openAddNewNumber(FavoritePlaceInfo placeInfo, String phoneNumber) async {
    emit(LoadingState());
    Map<String, dynamic> data = {
      'name': placeInfo.name,
      'openHours': placeInfo.openHours,
      'description': placeInfo.description,
      'phoneNumber': phoneNumber,
    };

    await db.collection('favorites').doc(placeInfo.name).update(data);
    emit(UpdatedPhoneSuccess());
  }

  void selectItemToBeDeleted(int selectedItem) {
    selectedItemToDelete = selectedItem;
    emit(SuccessState(currentPlaceList, false, selectedItem));
  }

  void deleteItem(String placeName, int index) async {
    emit(LoadingState());

    currentPlaceList.removeAt(index);
    await db.collection('favorites').doc(placeName).delete();
    if (currentPlaceList.isEmpty) {
      emit(EmptyListState());
    } else {
      emit(SuccessState(currentPlaceList, false, -1));
    }
  }
}
