import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_screen_state.dart';

class FavoriteScreenCubit extends Cubit<EventsScreenState> {
  FavoriteScreenCubit(super.initialState);

  final apiKey = 'AIzaSyAeFQsZFQ1uTHm53Brfxu4AH3R8JBHvj9M';

  void setInitialState() async {
    emit(LoadingState());
  }

  void checkUserLocation() async {}

  void loadEvents() async {
    emit(LoadingState());
    await Future.delayed(const Duration(milliseconds: 2000));
    emit(EmptyState());
  }
}
