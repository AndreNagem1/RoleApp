import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/screens/events_screen/data/evento.dart';
import 'package:rolesp/screens/events_screen/domain/events_screen_state.dart';

class EventsScreenCubit extends Cubit<EventsScreenState> {
  final db = FirebaseFirestore.instance;

  EventsScreenCubit(super.initialState);

  void loadEvents() async {
    final eventsList = <Event>[];
    await db.collection('eventos').get().then((event) {
      for (var doc in event.docs) {
        final newEvent = Event(
            name: doc['nome'],
            desciption: doc['descricao'],
            data: doc['data'],
            imagem: doc['imagem']);

        eventsList.add(newEvent);
      }
    });

    eventsList.sort((e1, e2) => e1.data.compareTo(e2.data));
    emit(EventsLoadedSuccessState(eventsList));
  }
}
