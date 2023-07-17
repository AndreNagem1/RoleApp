import 'package:rolesp/screens/map_screen/domain/states/auto_complete_state.dart';

abstract class AutoCompleteRepository {
  Future<AutoCompleteState> searchPlaces(String input);
}
