import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolesp/mock/NearbyPlacesMocked.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/screens/favorite_screen/favorite_screen.dart';
import 'package:rolesp/screens/home_screen/home_screen.dart';
import 'package:rolesp/screens/map_screen/ui/map_screen.dart';

import '../../../Resources/ColorsRoleSp.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = const SizedBox();

    switch (_index) {
      case 0:
        currentScreen =  MapScreen(
          places: NearbyPlacesResponse(
            results: NearbyPlacesMocked().mockedList
          ),
        );
        break;
      case 1:
        currentScreen = const FavoriteScreen(
          response: null,
        );
        break;
      case 2:
        currentScreen = const FavoriteScreen(
          response: null,
        );
        break;
      case 3:
        currentScreen = const HomeScreen();
        break;
    }

    return Scaffold(
      body: SizedBox.expand(child: currentScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorsRoleSp.searchBackground,
        unselectedItemColor: Colors.white38,
        fixedColor: ColorsRoleSp.white,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined), label: "Mapa"),
          BottomNavigationBarItem(
              icon: Icon(Icons.event_available), label: "Eventos"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favoritos"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}
