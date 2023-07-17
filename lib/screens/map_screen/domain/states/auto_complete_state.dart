import 'package:rolesp/models/auto_complete_response.dart';
import 'package:rolesp/screens/map_screen/domain/errors/failure.dart';

abstract class AutoCompleteState {}

class AutoCompleteInitialState extends AutoCompleteState {
  List<Object> get props => [];
}

class AutoCompletePredictions extends AutoCompleteState {
  AutoCompletePredictions(this.listPredictions);

  final List<Predictions> listPredictions;

  List<Object> get props => [listPredictions];
}

class ErrorStateAutoComplete implements AutoCompleteState {
  final Failure error;

  const ErrorStateAutoComplete(this.error);
}
