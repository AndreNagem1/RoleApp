import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/mock/NearbyPlacesMocked.dart';
import '../states/SplashScreenState.dart';

class SplashCubit extends Cubit<SplashScreenState> {
  SplashCubit(super.initialState);

  void setInitialState() async {
    emit(SplashScreenInitialtate());
  }

  void checkUserLocation() async {}

  void loadNearbyPlaces() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    emit(SplashCompleteSearch(NearbyPlacesMocked().mockedList));
  }
}
