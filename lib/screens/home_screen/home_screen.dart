import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/screens/home_screen/home_cubit.dart';
import 'package:rolesp/screens/home_screen/home_screen_state.dart';
import 'package:rolesp/screens/map_screen/map_screen.dart';
import 'package:rolesp/widgets/home_banner.dart';
import 'package:rolesp/widgets/home_icon.dart';
import 'package:rolesp/widgets/home_search_bar.dart';
import 'package:rolesp/widgets/loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = HomeCubit();
    return Scaffold(
      backgroundColor: ColorsRoleSp.background,
      body: BlocBuilder<HomeCubit, HomeScreenState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is Loading) {
            const LoadingScreeen();
          }
          return Column(
            children: [
              const HomeBanner(),
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
                      children: [
                        HomeIcon(
                          icon: Icons.restaurant,
                          title: 'Restaurante',
                          onItemClick: () {
                            _onItemClick('Restaurante', bloc);
                          },
                        ),
                        const SizedBox(width: 5),
                        HomeIcon(
                          icon: Icons.fastfood_rounded,
                          title: 'FastFood',
                          onItemClick: () {
                            _onItemClick('FastFood', bloc);
                          },
                        ),
                        const SizedBox(width: 5),
                        HomeIcon(
                          icon: Icons.coffee_rounded,
                          title: 'Cafés',
                          onItemClick: () {
                            _onItemClick('Cafés', bloc);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeIcon(
                          icon: Icons.directions_run,
                          title: 'Ar livre',
                          onItemClick: () {
                            _onItemClick('Ar livre', bloc);
                          },
                        ),
                        const SizedBox(width: 5),
                        HomeIcon(
                          icon: Icons.event_available,
                          title: 'Eventos',
                          onItemClick: () {
                            _onItemClick('Eventos', bloc);
                          },
                        ),
                        const SizedBox(width: 5),
                        HomeIcon(
                          icon: Icons.shopping_bag_outlined,
                          title: 'Shopping',
                          onItemClick: () {
                            _onItemClick('Shopping', bloc);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeIcon(
                          icon: Icons.local_drink_outlined,
                          title: 'Bar',
                          onItemClick: () {
                            _onItemClick('Bar', bloc);
                          },
                        ),
                        const SizedBox(width: 5),
                        HomeIcon(
                          icon: Icons.map_outlined,
                          title: 'Mapa',
                          onItemClick: () {
                            _navigateToMapScreen(context);
                          },
                        ),
                        const SizedBox(width: 5),
                        HomeIcon(
                          icon: Icons.star,
                          title: 'Favoritos',
                          onItemClick: () {
                            _onItemClick('Favoritos', bloc);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _onItemClick(String category, Cubit cubit) {}

  _navigateToMapScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapScreen()),
    );
  }
}
