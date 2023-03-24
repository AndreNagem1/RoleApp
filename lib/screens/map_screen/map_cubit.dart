import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rolesp/models/auto_complete_response.dart';
import 'package:rolesp/screens/map_screen/map_screen_state.dart';

class AutoCompleteCubit extends Cubit<AutoCompleteState> {
  AutoCompleteCubit() : super(AutoCompleteInitialState());

  final apiKey = 'AIzaSyAeFQsZFQ1uTHm53Brfxu4AH3R8JBHvj9M';

  void searchPlaces(String input) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?' +
            'input=' +
            input +
            '&key=' +
            apiKey);

    var response = await http.post(url);

    var autoCompleteResponse =
        AutoCompleteResponse.fromJson(jsonDecode(response.body));

    if (autoCompleteResponse.predictions?.isNotEmpty == true) {
      emit(AutoCompletePredictions(autoCompleteResponse.predictions!));
    }
  }
}
