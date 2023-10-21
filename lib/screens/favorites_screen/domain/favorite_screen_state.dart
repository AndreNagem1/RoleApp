import '../../../models/places_nearby_response.dart';
import '../../../modules/login/domain/errors/errors.dart';

abstract class EventsScreenState {}

class LoadingState extends EventsScreenState {
  List<Object> get props => [];
}

class EmptyState extends EventsScreenState {
  List<Object> get props => [];
}

class EventsLoadedSuccessState extends EventsScreenState {
  EventsLoadedSuccessState(this.listPredictions);

  final List<Results> listPredictions;

  List<Object> get props => [listPredictions];
}

class ErrorState implements EventsScreenState {
  final Failure error;

  const ErrorState(this.error);
}
