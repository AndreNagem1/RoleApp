import 'package:rolesp/models/auto_complete_response.dart';
import 'package:dio/dio.dart';
import 'package:rolesp/screens/map_screen/data/datasources/auto_complete_datasource.dart';
import 'dart:convert';

class GoogleAutoCompleteDatasource implements AutoCompleteDataSource {
  final apiKey = 'AIzaSyDHqcABOOAoDDqR-UnJA5W7YwDVAa2t884';
  final Dio dio = Dio();

  GoogleAutoCompleteDatasource();

  @override
  Future<List<Predictions>> searchPlaces(String input) async {
    var url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?' +
        'input=' +
        input +
        '&language=pt&key=' +
        apiKey;

    var response = await dio.post(url);

    if (response.statusCode == 200) {
      var autoCompleteResponse =
          AutoCompleteResponse.fromJson(jsonDecode(response.data));

      if (autoCompleteResponse.predictions?.isNotEmpty == true) {
        return autoCompleteResponse.predictions!;
      } else {
        return List.empty();
      }
    } else {
      throw Exception();
    }
  }
}
