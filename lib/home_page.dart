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
        color: ColorsRoleSp.background,
        child: Column(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/big_logo.png',
                            height: 100,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              ColorsRoleSp.background12,
                              ColorsRoleSp.background,
                            ],
                          ),
                        ),
                      ),
                    ],
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
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: ColorsRoleSp.searchBorder,
                        ),
                        color: ColorsRoleSp.blackIcon,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: const [
                          SizedBox(width: 10),
                          Icon(
                            Icons.search,
                            size: 30,
                            color: ColorsRoleSp.white,
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
                          color: ColorsRoleSp.blackIcon,
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
                          color: ColorsRoleSp.blackIcon,
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
                          color: ColorsRoleSp.blackIcon,
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
                          color: ColorsRoleSp.blackIcon,
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
                          color: ColorsRoleSp.blackIcon,
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
                          color: ColorsRoleSp.blackIcon,
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
                          color: ColorsRoleSp.blackIcon,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const HomeIcon(
                          icon: Icons.local_drink_outlined,
                          title: 'Bar',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 90,
                        height: 75,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: ColorsRoleSp.blackIcon,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const HomeIcon(
                          icon: Icons.map_outlined,
                          title: 'Mapa',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 90,
                        height: 75,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: ColorsRoleSp.blackIcon,
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
