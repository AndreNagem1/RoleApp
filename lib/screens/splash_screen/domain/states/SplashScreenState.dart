import 'package:rolesp/models/places_nearby_response.dart';

import '../../../../modules/login/domain/errors/errors.dart';

abstract class SplashScreenState {}

class SplashScreenInitialtate extends SplashScreenState {
  List<Object> get props => [];
}

class SplashCompleteSearch extends SplashScreenState {
  SplashCompleteSearch(this.listPredictions);

  final List<Results> listPredictions;

  List<Object> get props => [listPredictions];
}

class ErrorStateAutoComplete implements SplashScreenState {
  final Failure error;

  const ErrorStateAutoComplete(this.error);
}
