import 'package:rolesp/models/events_list.dart';

import '../../../modules/login/domain/errors/errors.dart';

abstract class FavoritsScreenState {}

class EmptyState extends FavoritsScreenState {
  List<Object> get props => [];
}

class LoadingState extends FavoritsScreenState {
  List<Object> get props => [];
}

class EventsLoadedSuccessState extends FavoritsScreenState {
  EventsLoadedSuccessState(this.listEvents);

  final List<Events> listEvents;

  List<Object> get props => [listEvents];
}

class ErrorState implements FavoritsScreenState {
  final Failure error;

  const ErrorState(this.error);
}
