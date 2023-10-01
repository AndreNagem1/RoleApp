import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 30),
                      Text(
                        'Olá, André :)',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: ColorsRoleSp.whiteLetter,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 300),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Developed by FoxTeam',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: ColorsRoleSp.whiteLetter,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Image.asset(
                        'assets/images/fox.png',
                        height: 25,
                        width: 25,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Versão 1.0.0',
                        style: GoogleFonts.roboto(
                          fontSize: 10,
                          color: ColorsRoleSp.smoothLetter,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
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
