import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/screens/map_screen/list_places_state.dart';

class ListPlacesCubit extends Cubit<ListPlacesState> {
  ListPlacesCubit() : super(ListPlacesInitialState());

  void setListPlaces(List<Results> listPlaces) {
    if (listPlaces.isNotEmpty) {
      emit(ListPlaces(listPlaces));
    }
  }

  void setInitialState() {
    emit(ListPlacesInitialState());
  }
}
