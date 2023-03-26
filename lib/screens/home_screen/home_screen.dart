import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/models/places_nearby_response.dart';
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
  final bloc = HomeCubit();

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Scaffold(
      backgroundColor: ColorsRoleSp.background,
      body: BlocBuilder<HomeCubit, HomeScreenState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is Loading) {
            return const LoadingScreen();
          }
          if (state is NavigateToMap) {
            _scheduleNavigateToMapScreen(context, state.nearbyPlacesResponse);
            bloc.setInitialState();
            return const LoadingScreen();
          }
          return Column(
            children: [
              const HomeBanner(),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    SearchBar(
                      onSearch: (text) {},
                      onSubmitted: (text) {},
                      controller: textController,
                      onTap: () {},
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeIcon(
                          icon: Icons.restaurant,
                          title: 'Restaurante',
                          onItemClick: () {
                            _onItemClick('restaurant', bloc);
                          },
                        ),
                        const SizedBox(width: 5),
                        HomeIcon(
                          icon: Icons.fastfood_rounded,
                          title: 'FastFood',
                          onItemClick: () {
                            _onItemClick('restaurant', bloc);
                          },
                        ),
                        const SizedBox(width: 5),
                        HomeIcon(
                          icon: Icons.coffee_rounded,
                          title: 'Cafés',
                          onItemClick: () {
                            _onItemClick('bakery', bloc);
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
                            _onItemClick('restaurant', bloc);
                          },
                        ),
                        const SizedBox(width: 5),
                        HomeIcon(
                          icon: Icons.event_available,
                          title: 'Eventos',
                          onItemClick: () {
                            _onItemClick('restaurant', bloc);
                          },
                        ),
                        const SizedBox(width: 5),
                        HomeIcon(
                          icon: Icons.shopping_bag_outlined,
                          title: 'Shopping',
                          onItemClick: () {
                            _onItemClick('restaurant', bloc);
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
                            _navigateToMapScreen(context, null);
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

  _onItemClick(String category, HomeCubit cubit) {
    cubit.getNearByPlaces(category);
  }

  _navigateToMapScreen(BuildContext context, NearbyPlacesResponse? places) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapScreen(places: places)),
    );
  }

  _scheduleNavigateToMapScreen(
      BuildContext context, NearbyPlacesResponse? places) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _navigateToMapScreen(context, places);
    });
  }
}
