import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/screens/favorite_screen/ui/favorite_screen.dart';
import 'package:rolesp/screens/home_screen/home_cubit.dart';
import 'package:rolesp/screens/home_screen/home_screen_state.dart';
import 'package:rolesp/screens/map_screen/ui/BottomNavigation.dart';
import 'package:rolesp/screens/map_screen/ui/map_screen.dart';
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
          if (state is NavigateToFavorites) {
            _scheduleNavigateToFavoriteScreen(
                context, state.nearbyPlacesResponse);
            bloc.setInitialState();
            return const LoadingScreen();
          }

          return Column(
            children: [
              const HomeBanner(),
              const SizedBox(height: 15),
              HomeIcon(
                icon: Icons.person,
                title: 'André',
                onItemClick: () {
                  _navigateToMapScreen(context, null);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    HomeSearchBar(
                      onSearch: (text) {},
                      onSubmitted: (text) {},
                      controller: textController,
                      onTap: () {},
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HomeIcon(
                          icon: Icons.map_outlined,
                          title: 'Mapa',
                          onItemClick: () {
                            _navigateToMapScreen(context, null);
                          },
                        ),
                        HomeIcon(
                          icon: Icons.star,
                          title: 'Favoritos',
                          onItemClick: () {
                            _onFavoriteClick(bloc);
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    const BottomNavigation()
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

  _onFavoriteClick(HomeCubit cubit) {
    cubit.getFavoritePlaces();
  }

  _navigateToFavoriteScreen(
      BuildContext context, NearbyPlacesResponse? places) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoriteScreen(response: places),
      ),
    );
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

  _scheduleNavigateToFavoriteScreen(
      BuildContext context, NearbyPlacesResponse? places) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _navigateToFavoriteScreen(context, places);
    });
  }
}
