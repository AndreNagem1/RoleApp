import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/main/main.dart';
import 'package:rolesp/models/places_nearby_response.dart';
import 'package:rolesp/screens/map_screen/ui/map_screen.dart';
import 'package:rolesp/screens/settings_screen/settings_cubit.dart';
import 'package:rolesp/screens/settings_screen/settings_screen_state.dart';
import 'package:rolesp/widgets/home_banner.dart';
import 'package:rolesp/widgets/loading.dart';

import '../../theme/themeManager.dart';
import '../favorites_screen/ui/favorites_screen.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeManager themeManager;

  SettingsScreen({Key? key, required this.themeManager}) : super(key: key);

  final bloc = SettingsCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<SettingsCubit, SettingsScreenState>(
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
                      Switch(
                        activeColor: Theme.of(context).colorScheme.tertiary,
                          inactiveThumbColor: Theme.of(context).colorScheme.onTertiary,
                          value: themeManager.themeMode == ThemeMode.dark,
                          onChanged: (newValue) {
                            themeManager.toggleTheme(newValue);
                          })
                    ],
                  ),
                  const SizedBox(height: 250),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Developed by FoxTeam',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurface,
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
                          color: Theme.of(context).colorScheme.onSurface,
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
