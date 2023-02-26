import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class DB {
  DB._();

  static final DB _instance = DB._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static get() {
    return DB._instance._firestore;
  }

  static setupDemoData() async {
    FirebaseFirestore firestore = DB.get();
    final geo = Geoflutterfire();

    List<GeoFirePoint> cafes = [
      geo.point(latitude: -23.4944928, longitude: -46.8575523),
      geo.point(latitude: -23.4944928, longitude: -46.8475523),
      geo.point(latitude: -23.4944928, longitude: -46.8375523),
      geo.point(latitude: -23.4944928, longitude: -46.8275523),
      geo.point(latitude: -23.4944928, longitude: -46.8175523),
    ];
    final dados = [
      {
        'nome': 'The Coffee',
        'imagem':
            'https://thecoffee.s3-sa-east-1.amazonaws.com/images/the_coffee_berrini.jpeg',
        'position': cafes[0].data,
      },
      {
        'nome': 'The Coffee II',
        'imagem':
            'https://thecoffee.s3-sa-east-1.amazonaws.com/images/SP-Itaim-2.jpg',
        'position': cafes[1].data,
      },
      {
        'nome': 'The Coffee III',
        'imagem':
            'https://thecoffee.s3-sa-east-1.amazonaws.com/images/the_coffee_market_place.jpeg',
        'position': cafes[2].data,
      },
      {
        'nome': 'The Coffee IV',
        'imagem':
            'https://lh5.googleusercontent.com/p/AF1QipN2DS1CHddvUSz1IoLxP6Y411SPgFY2qefVDoah=w408-h544-k-no',
        'position': cafes[3].data,
      },
      {
        'nome': 'The Coffee Faria Lima',
        'imagem':
            'https://lh5.googleusercontent.com/p/AF1QipN2DS1CHddvUSz1IoLxP6Y411SPgFY2qefVDoah=w408-h544-k-no',
        'position': cafes[4].data,
      },
    ];

    await firestore.collection('cafes').add(dados[0]);
    await firestore.collection('cafes').add(dados[1]);
    await firestore.collection('cafes').add(dados[2]);
    await firestore.collection('cafes').add(dados[3]);
    await firestore.collection('cafes').add(dados[4]);
  }
}
