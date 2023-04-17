import 'package:rolesp/models/place_details_response.dart';
import 'package:rolesp/models/places_nearby_response.dart';

class NearbyPlacesMocked {
  late List<Results> mockedList;

  NearbyPlacesMocked() {
    final review1 =
        Reviews(authorName: 'Andre Nagem', rating: 5, text: 'Amei o lugar s2');
    final review2 =
        Reviews(authorName: 'João menó', rating: 5, text: 'Top demais !');
    final review3 =
        Reviews(authorName: 'Leozito', rating: 5, text: 'Cerveja gelada :D');
    final mock1 = Results(
        name: 'Restaurante 1',
        placeId: 'r1',
        types: ['Hamburguer', 'Cerveja', 'Role'],
        reviews: [review1, review2, review3]);
    final mock2 = Results(
        name: 'Restaurante 1',
        placeId: 'r1',
        types: ['Hamburguer', 'Cerveja', 'Role'],
        reviews: [review1, review2, review3]);
    final mock3 = Results(
        name: 'Restaurante 1',
        placeId: 'r1',
        types: ['Hamburguer', 'Cerveja', 'Role'],
        reviews: [review1, review2, review3]);

    final mock4 = Results(
        name: 'Restaurante 1',
        placeId: 'r1',
        types: ['Hamburguer', 'Cerveja', 'Role'],
        reviews: [review1, review2, review3]);
    final mock5 = Results(
        name: 'Restaurante 1',
        placeId: 'r1',
        types: ['Hamburguer', 'Cerveja', 'Role'],
        reviews: [review1, review2, review3]);
    final mock6 = Results(
        name: 'Restaurante 1',
        placeId: 'r1',
        types: ['Hamburguer', 'Cerveja', 'Role'],
        reviews: [review1, review2, review3]);
    final mock7 = Results(
        name: 'Restaurante 1',
        placeId: 'r1',
        types: ['Hamburguer', 'Cerveja', 'Role'],
        reviews: [review1, review2, review3]);
    final mock8 = Results(
        name: 'Restaurante 1',
        placeId: 'r1',
        types: ['Hamburguer', 'Cerveja', 'Role'],
        reviews: [review1, review2, review3]);
    final mock9 = Results(
        name: 'Restaurante 1',
        placeId: 'r1',
        types: ['Hamburguer', 'Cerveja', 'Role'],
        reviews: [review1, review2, review3]);
    final mock10 = Results(
        name: 'Restaurante 1',
        placeId: 'r1',
        types: ['Hamburguer', 'Cerveja', 'Role'],
        reviews: [review1, review2, review3]);

    mockedList = [
      mock1,
      mock2,
      mock3,
      mock4,
      mock5,
      mock6,
      mock7,
      mock8,
      mock9,
      mock10,
    ];
  }
}
