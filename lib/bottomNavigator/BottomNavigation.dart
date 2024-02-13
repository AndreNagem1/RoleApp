import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rolesp/main_cubit.dart';
import 'package:rolesp/mock/NearbyPlacesMocked.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/screens/events_screen/ui/events_screen.dart';
import 'package:rolesp/screens/map_screen/ui/map_screen.dart';
import 'package:rolesp/screens/settings_screen/settings_screen.dart';

import '../screens/favorites_screen/ui/favorites_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final MainCubit mainCubit = Modular.get<MainCubit>();
  var _index = 0;

  @override
  void initState() {
    super.initState();
    _index = mainCubit.selectedBottomNavItem;
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = const SizedBox();

    switch (_index) {
      case 0:
        currentScreen = MapScreen();
        break;
      case 1:
        currentScreen = const EventsScreen();
        break;
      case 2:
        currentScreen = const FavoriteScreen();
        break;
      case 3:
        currentScreen = SettingsScreen();
        break;
    }

    return Scaffold(
      body: SizedBox.expand(child: currentScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.surface,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        fixedColor: Theme.of(context).colorScheme.onSurface,
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
