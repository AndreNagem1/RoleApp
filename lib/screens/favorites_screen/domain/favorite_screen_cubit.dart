import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../mock/NearbyPlacesMocked.dart';
import 'favorite_screen_state.dart';

class FavoriteScreenCubit extends Cubit<FavoritsScreenState> {
  FavoriteScreenCubit(super.initialState);

  void loadFavoritesPlaces() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    emit(SuccessState(NearbyPlacesMocked().mockedList, false));
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
    emit(SuccessState(NearbyPlacesMocked().mockedList, true));
  }
}
