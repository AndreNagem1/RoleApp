import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../mock/EventsListMocked.dart';
import 'favorite_screen_state.dart';

class FavoriteScreenCubit extends Cubit<FavoritsScreenState> {
  FavoriteScreenCubit(super.initialState);

  void checkUserLocation() async {}

  void loadEvents() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    emit(EventsLoadedSuccessState(eventsMocked.events ?? []));
  }
}
