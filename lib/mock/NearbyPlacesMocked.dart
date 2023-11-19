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

    final listHours = [
      ':8h - 19h',
      ':8h - 19h',
      ':8h - 19h',
      ':8h - 19h',
      ':8h - 19h',
      ':8h - 19h',
      ':8h - 19h',
    ];

    final openingHours = OpeningHours(
      openNow: true,
      weekdayText: listHours,
    );

    final openingHours2 = OpeningHours(
      openNow: false,
      weekdayText: listHours,
    );

    final mock1 = Results(
        name: 'Black Horse',
        placeId: 'r1',
        types: ['Hamburguer', 'Cerveja', 'Role'],
        reviews: [review1, review2, review3],
        openingHours: openingHours,
        geometry: geometry1,
        rating: 5,
        userRatingsTotal: 730,
        phone: '',
        vicinity: 'Rua alberto de almeida 130');
    final mock2 = Results(
      name: 'Frutaria São Paulo',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      reviews: [review1, review2, review3],
      openingHours: openingHours2,
      geometry: geometry2,
      rating: 3,
      userRatingsTotal: 19,
      phone: '+112495090',
      vicinity: 'Rua alberto de almeida 130',
    );
    final mock3 = Results(
      name: 'Pivot',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      reviews: [review1, review2, review3],
      openingHours: openingHours,
      geometry: geometry3,
      rating: 2,
      userRatingsTotal: 230,
      phone: '+112495090',
      vicinity: 'Rua alberto de almeida 130',
    );

    final mock4 = Results(
      name: 'Bistro',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      reviews: [review1, review2, review3],
      openingHours: openingHours,
      geometry: geometry4,
      rating: 3,
      userRatingsTotal: 340,
      phone: '',
      vicinity: 'Rua alberto de almeida 130',
    );
    final mock5 = Results(
      name: 'Mauí Poke',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      reviews: [review1, review2, review3],
      openingHours: openingHours,
      geometry: geometry5,
      rating: 1,
      userRatingsTotal: 10,
      phone: '+112495090',
      vicinity: 'Rua alberto de almeida 130',
    );
    final mock6 = Results(
      name: 'Maria João',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      reviews: [review1, review2, review3],
      openingHours: openingHours2,
      geometry: geometry6,
      rating: 2,
      phone: '+112495090',
      userRatingsTotal: 3000,
    );
    final mock7 = Results(
      name: 'Kombina Felice',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      reviews: [review1, review2, review3],
      openingHours: openingHours2,
      geometry: geometry7,
      rating: 4.2,
      phone: '+112495090',
      userRatingsTotal: 63,
    );
    final mock8 = Results(
      name: 'Restaurante America',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      reviews: [review1, review2, review3],
      openingHours: openingHours,
      geometry: geometry8,
      rating: 3.3,
      phone: '',
      userRatingsTotal: 150,
    );
    final mock9 = Results(
      name: 'Bar do Alemão',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      reviews: [review1, review2, review3],
      openingHours: openingHours,
      geometry: geometry6,
      rating: 1.5,
      phone: '',
      userRatingsTotal: 40,
    );
    final mock10 = Results(
      name: 'Real Burguer',
      placeId: 'r1',
      types: ['Hamburguer', 'Cerveja', 'Role'],
      openingHours: openingHours,
      reviews: [review1, review2, review3],
      geometry: geometry,
      phone: '',
      rating: 2.5,
      userRatingsTotal: 630,
    );

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
