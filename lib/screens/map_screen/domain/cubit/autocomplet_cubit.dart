import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/screens/map_screen/domain/states/auto_complete_state.dart';
import 'package:rolesp/screens/map_screen/domain/repositories/auto_complete_repository.dart';

class AutoCompleteCubit extends Cubit<AutoCompleteState> {
  final AutoCompleteRepository repository;

  AutoCompleteCubit(this.repository) : super(AutoCompleteInitialState());

  void searchPlaces(String input) async {
    var newState = await repository.searchPlaces(input);
    emit(newState);
  }

  void setInitialState() {
    emit(AutoCompleteInitialState());
  }
}
