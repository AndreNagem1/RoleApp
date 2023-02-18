import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolesp/ColorsRoleSp.dart';
import 'package:rolesp/map_page.dart';
import 'package:rolesp/widgets/home_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 350,
              color: Colors.red,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/city.jpg',
                    fit: BoxFit.fill,
                    height: 350,
                  ),
                  Image.asset(
                    'assets/images/big_logo.png',
                    height: 350,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _navigateToMapScreen(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: const [
                          SizedBox(width: 10),
                          Icon(
                            Icons.search,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 90,
                        height: 75,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const HomeIcon(
                          icon: Icons.restaurant,
                          title: 'Restaurante',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 90,
                        height: 75,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const HomeIcon(
                          icon: Icons.fastfood_rounded,
                          title: 'FastFood',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 90,
                        height: 75,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const HomeIcon(
                          icon: Icons.coffee_rounded,
                          title: 'Cafés',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 90,
                        height: 75,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const HomeIcon(
                          icon: Icons.directions_run,
                          title: 'Ar livre',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 90,
                        height: 75,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const HomeIcon(
                          icon: Icons.event_available,
                          title: 'Eventos',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 90,
                        height: 75,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const HomeIcon(
                          icon: Icons.shopping_bag_outlined,
                          title: 'Shopping',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 90,
                        height: 75,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const HomeIcon(
                          icon: Icons.wallet_travel_outlined,
                          title: 'Turismo',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 90,
                        height: 75,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const HomeIcon(
                          icon: Icons.hotel_rounded,
                          title: 'Hotel',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 90,
                        height: 75,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const HomeIcon(
                          icon: Icons.star,
                          title: 'Favoritos',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _navigateToMapScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapPage()),
    );
  }
}