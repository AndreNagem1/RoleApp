import 'package:rolesp/models/auto_complete_response.dart';

abstract class AutoCompleteDataSource {
  Future<List<Predictions>> searchPlaces(String input);
}
