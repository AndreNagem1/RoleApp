import 'package:rolesp/models/place_details_response.dart';
import 'package:rolesp/models/places_nearby_response.dart';

class NearbyPlacesMocked {
  late List<Results> mockedList;

  NearbyPlacesMocked() {
    Geometry geometry = Geometry(
        location: Location(
      lat: -23.486914,
      lng: -46.8710581,
    ));
    Geometry geometry1 = Geometry(
        location: Location(
      lat: -23.486514,
      lng: -46.8715581,
    ));
    Geometry geometry2 = Geometry(
        location: Location(
      lat: -23.486014,
      lng: -46.8911581,
    ));
    Geometry geometry3 = Geometry(
        location: Location(
      lat: -23.486014,
      lng: -46.8911581,
    ));
    Geometry geometry4 = Geometry(
        location: Location(
      lat: -23.486914,
      lng: -46.8940581,
    ));
    Geometry geometry5 = Geometry(
        location: Location(
      lat: -23.488914,
      lng: -46.8950581,
    ));
    Geometry geometry6 = Geometry(
        location: Location(
      lat: -23.486014,
      lng: -46.8971581,
    ));
    Geometry geometry7 = Geometry(
        location: Location(
      lat: -23.489914,
      lng: -46.898581,
    ));
    Geometry geometry8 = Geometry(
        location: Location(
      lat: -23.483994,
      lng: -46.890581,
    ));
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
      reviews: [review1, review2, review3],
      geometry: geometry1,
    );
    final mock2 = Results(
      name: 'Restaurante 2',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      reviews: [review1, review2, review3],
      geometry: geometry2,
    );
    final mock3 = Results(
      name: 'Restaurante 3',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      reviews: [review1, review2, review3],
      geometry: geometry3,
    );

    final mock4 = Results(
      name: 'Restaurante 4',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      reviews: [review1, review2, review3],
      geometry: geometry4,
    );
    final mock5 = Results(
      name: 'Restaurante 5',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      reviews: [review1, review2, review3],
      geometry: geometry5,
    );
    final mock6 = Results(
      name: 'Restaurante 6',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      reviews: [review1, review2, review3],
      geometry: geometry6,
    );
    final mock7 = Results(
      name: 'Restaurante 7',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      reviews: [review1, review2, review3],
      geometry: geometry7,
    );
    final mock8 = Results(
      name: 'Restaurante 8',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      reviews: [review1, review2, review3],
      geometry: geometry8,
    );
    final mock9 = Results(
      name: 'Restaurante 9',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      reviews: [review1, review2, review3],
      geometry: geometry6,
    );
    final mock10 = Results(
        name: 'Restaurante 10',
        placeId: 'r1',
        types: ['Hamburguer', 'Cerveja', 'Role'],
        reviews: [review1, review2, review3],
        geometry: geometry);

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
