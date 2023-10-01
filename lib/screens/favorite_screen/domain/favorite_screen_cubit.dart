import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../mock/NearbyPlacesMocked.dart';
import 'favorite_screen_state.dart';

class FavoriteScreenCubit extends Cubit<FavoriteScreenState> {
  FavoriteScreenCubit(super.initialState);

  void setInitialState() async {
    emit(FavoriteScreenInitialtate());
  }

  void checkUserLocation() async {}

  void loadNearbyPlaces() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    emit(FavoriteScreenCompleteSearch(NearbyPlacesMocked().mockedList));
  }
}
