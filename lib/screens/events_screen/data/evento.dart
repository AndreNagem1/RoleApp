import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String name;
  String desciption;
  Timestamp data;
  String imagem;
  String address;

  Event(
      {required this.name,
      required this.desciption,
      required this.data,
      required this.imagem,
      required this.address});
}
