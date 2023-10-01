import '../../../models/places_nearby_response.dart';
import '../../../modules/login/domain/errors/errors.dart';

abstract class FavoriteScreenState {}

class FavoriteScreenInitialtate extends FavoriteScreenState {
  List<Object> get props => [];
}

class FavoriteScreenCompleteSearch extends FavoriteScreenState {
  FavoriteScreenCompleteSearch(this.listPredictions);

  final List<Results> listPredictions;

  List<Object> get props => [listPredictions];
}

class ErrorStateAutoComplete implements FavoriteScreenState {
  final Failure error;

  const ErrorStateAutoComplete(this.error);
}
