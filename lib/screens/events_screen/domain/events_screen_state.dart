import 'package:rolesp/screens/events_screen/data/evento.dart';

import '../../../modules/login/domain/errors/errors.dart';

abstract class EventsScreenState {}

class EmptyState extends EventsScreenState {
  List<Object> get props => [];
}

class LoadingState extends EventsScreenState {
  List<Object> get props => [];
}

class ErrorState implements EventsScreenState {
  final Failure error;

  const ErrorState(this.error);
}

class EventsLoadedSuccessState extends EventsScreenState {
  final List<Event> eventsList;

  EventsLoadedSuccessState(this.eventsList);
}
