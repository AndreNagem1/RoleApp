import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Controllers/map_controller.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/models/places_nearby_response.dart';

class PlacesListItem extends StatelessWidget {
  final Results? results;
  final VoidCallback onTap;
  final apiKey = 'AIzaSyAeFQsZFQ1uTHm53Brfxu4AH3R8JBHvj9M';

  const PlacesListItem({
    Key? key,
    required this.results,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUrl = '';

    if (results?.photos?[0] != null) {
      imageUrl =
          'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=' +
              results!.photos![0].photoReference! +
              '&key=' +
              apiKey;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 350,
        height: 350,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          color: ColorsRoleSp.blackIcon,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 150,
              alignment: Alignment.center,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => const SizedBox(
                  child: CircularProgressIndicator(
                    color: ColorsRoleSp.perfectPurple,
                  ),
                  height: 20,
                  width: 20,
                ),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/blackHorse.jpg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        height: 35,
                        width: 200,
                        child: Text(
                          results?.name ?? '',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      getDescription(results?.types ?? ['Restautante']),
                      style: GoogleFonts.acme(
                        textStyle:
                            const TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 100,
                          child: Image.asset('assets/images/avaliations9.png'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getDescription(List<String> types) {
    var description = '';
    var index = 0;
    while (index < 3) {
      var type = types[index];
      type = translate(type);
      var separator = ' |';
      if (index == 2) {
        separator = '';
      }
      description += ' ' + type + separator;
      index++;
    }
    return description;
  }

  String translate(String type) {
    if (type.contains('meal')) {
      return 'Delivery';
    }
    if (type.contains('food')) {
      return 'Comida';
    }
    if (type.contains('bakery')) {
      return 'Padaria';
    }
    if (type.contains('cafe')) {
      return 'Café';
    }
    if (type.contains('bar')) {
      return 'Bar';
    }
    if (type.contains('restaurant')) {
      return 'Restaurante';
    }
    if (type.contains('health')) {
      return 'Saudável';
    }
    if (type.contains('point')) {
      return 'Lazer';
    }
    if (type.contains('store')) {
      return 'Loja';
    }
    return type;
  }
}
