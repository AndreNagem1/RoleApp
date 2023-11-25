import 'package:rolesp/models/favorite_place_info.dart';

import '../../../modules/login/domain/errors/errors.dart';

abstract class FavoritsScreenState {}

class EmptyState extends FavoritsScreenState {
  List<Object> get props => [];
}

class LoadingState extends FavoritsScreenState {
  List<Object> get props => [];
}

class EmptyListState extends FavoritsScreenState {
  List<Object> get props => [];
}

class SuccessState extends FavoritsScreenState {
  SuccessState(this.listFavoritePlaces, this.openAddNewNumber, this.selectedItemToDelete);

  final List<FavoritePlaceInfo> listFavoritePlaces;
  final bool openAddNewNumber;
  final int selectedItemToDelete;

  List<Object> get props => [listFavoritePlaces, openAddNewNumber, selectedItemToDelete];
}

class ErrorState implements FavoritsScreenState {
  final Failure error;

  const ErrorState(this.error);
}


class UpdatedPhoneSuccess extends FavoritsScreenState {
  List<Object> get props => [];
}