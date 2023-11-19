import '../../../models/places_nearby_response.dart';
import '../../../modules/login/domain/errors/errors.dart';

abstract class FavoritsScreenState {}

class EmptyState extends FavoritsScreenState {
  List<Object> get props => [];
}

class LoadingState extends FavoritsScreenState {
  List<Object> get props => [];
}

class SuccessState extends FavoritsScreenState {
  SuccessState(this.listFavoritePlaces, this.openAddNewNumber);

  final List<Results> listFavoritePlaces;
  final bool openAddNewNumber;

  List<Object> get props => [listFavoritePlaces, openAddNewNumber];
}

class ErrorState implements FavoritsScreenState {
  final Failure error;

  const ErrorState(this.error);
}