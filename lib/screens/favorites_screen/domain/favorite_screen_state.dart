import 'package:rolesp/models/events_list.dart';

import '../../../modules/login/domain/errors/errors.dart';

abstract class EventsScreenState {}

class EmptyState extends EventsScreenState {
  List<Object> get props => [];
}

class LoadingState extends EventsScreenState {
  List<Object> get props => [];
}

class EventsLoadedSuccessState extends EventsScreenState {
  EventsLoadedSuccessState(this.listEvents);

  final List<Events> listEvents;

  List<Object> get props => [listEvents];
}

class ErrorState implements EventsScreenState {
  final Failure error;

  const ErrorState(this.error);
}
