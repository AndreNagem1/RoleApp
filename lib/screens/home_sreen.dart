import 'package:flutter/material.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/screens/map_screen/map_screen.dart';
import 'package:rolesp/widgets/home_gradient_effect.dart';
import 'package:rolesp/widgets/home_icon.dart';
import 'package:rolesp/widgets/home_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsRoleSp.background,
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 350,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/city.jpg',
                  fit: BoxFit.fill,
                  height: 350,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/big_logo.png',
                    height: 100,
                  ),
                ),
                const HomeGradientEffect(),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                HomeSearchBar(
                  navigateToHome: () {
                    _navigateToMapScreen(context);
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    HomeIcon(
                      icon: Icons.restaurant,
                      title: 'Restaurante',
                    ),
                    SizedBox(width: 5),
                    HomeIcon(
                      icon: Icons.fastfood_rounded,
                      title: 'FastFood',
                    ),
                    SizedBox(width: 5),
                    HomeIcon(
                      icon: Icons.coffee_rounded,
                      title: 'Cafés',
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    HomeIcon(
                      icon: Icons.directions_run,
                      title: 'Ar livre',
                    ),
                    SizedBox(width: 5),
                    HomeIcon(
                      icon: Icons.event_available,
                      title: 'Eventos',
                    ),
                    SizedBox(width: 5),
                    HomeIcon(
                      icon: Icons.shopping_bag_outlined,
                      title: 'Shopping',
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    HomeIcon(
                      icon: Icons.local_drink_outlined,
                      title: 'Bar',
                    ),
                    SizedBox(width: 5),
                    HomeIcon(
                      icon: Icons.map_outlined,
                      title: 'Mapa',
                    ),
                    SizedBox(width: 5),
                    HomeIcon(
                      icon: Icons.star,
                      title: 'Favoritos',
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _navigateToMapScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  MapScreen()),
    );
  }
}
