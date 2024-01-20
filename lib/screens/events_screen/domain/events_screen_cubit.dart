import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
            longDescription: 'ahsuhauhsau asuh sauhuashuash usahasuh uhsuah uhsau shauashsa asuh uasuh uhasuhasu ',
            data: doc['data'],
            imagem: doc['imagem'],
            address: doc['endereco']);

        eventsList.add(newEvent);
      }
    });

    for (var event in eventsList) {
      event.imagem = await getImageUrl(event.imagem);
    }

    eventsList.sort((e1, e2) => e1.data.compareTo(e2.data));
    emit(EventsLoadedSuccessState(eventsList));
  }
}

Future<String> getImageUrl(String imagePath) async {
  final Reference storageRef = FirebaseStorage.instance.ref().child(imagePath);
  final String downloadURL = await storageRef.getDownloadURL();
  return downloadURL;
}
