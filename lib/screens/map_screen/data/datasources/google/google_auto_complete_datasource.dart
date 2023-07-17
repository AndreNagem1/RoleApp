import 'package:rolesp/models/auto_complete_response.dart';
import 'package:dio/dio.dart';
import 'package:rolesp/screens/map_screen/data/datasources/auto_complete_datasource.dart';
import 'package:rolesp/models/auto_complete_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class GoogleAutoCompleteDatasource implements AutoCompleteDataSource {

  final apiKey = 'AIzaSyAeFQsZFQ1uTHm53Brfxu4AH3R8JBHvj9M';
  final Dio dio;

  GoogleAutoCompleteDatasource(this.dio);

  @override
  Future<List<Predictions>> searchPlaces(String input) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?' +
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
