import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/models/favorite_place_info.dart';
import 'package:rolesp/screens/map_screen/domain/cubit/add_favorite_place_state.dart';

class AddFavoritePlaceCubit extends Cubit<AddFavoritePlaceDialogState> {
  final db = FirebaseFirestore.instance;

  AddFavoritePlaceCubit(super.initialState);

  void savePlaceAsFavorite(FavoritePlaceInfo placeInfo) async {
    emit(LoadingState());

    Map<String, dynamic> data = {
      'name': placeInfo.name,
      'openHours': placeInfo.openHours,
      'description': placeInfo.description,
      'phoneNumber': placeInfo.phoneNumber,
    };

    await db.collection('favorites').add(data);
    emit(InitialState());
  }
}
