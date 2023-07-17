import 'package:rolesp/screens/map_screen/domain/states/auto_complete_state.dart';
import 'package:rolesp/screens/map_screen/data/datasources/auto_complete_datasource.dart';
import 'package:rolesp/screens/map_screen/domain/errors/failure.dart';
import 'package:rolesp/screens/map_screen/domain/repositories/auto_complete_repository.dart';

class AutoCompleteRepositoryImpl implements AutoCompleteRepository {
  final AutoCompleteDataSource datasource;

  AutoCompleteRepositoryImpl(this.datasource);

  @override
  Future<AutoCompleteState> searchPlaces(String input) async {
    try {
      var list = await datasource.searchPlaces(input);
      return AutoCompletePredictions(list);
    } catch (e) {
      return ErrorStateAutoComplete(AutoCompleteError());
    }
  }
}
