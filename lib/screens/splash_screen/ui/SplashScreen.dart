import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rolesp/bottomNavigator/BottomNavigation.dart';
import 'package:rolesp/modules/login/presentation/login_screen.dart';
import 'package:rolesp/screens/splash_screen/domain/cubit/SplashCubit.dart';
import 'package:rolesp/screens/splash_screen/domain/states/SplashScreenState.dart';

import '../../../theme/themeManager.dart';

class SplashScreen extends StatelessWidget {
  final ThemeManager themeManager;

  const SplashScreen({Key? key, required this.themeManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = SplashCubit(SplashScreenInitialtate());

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/big_logo.png',
              height: 80,
            ),
            const SizedBox(height: 10),
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            BlocBuilder<SplashCubit, SplashScreenState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is SplashScreenInitialtate) {
                    cubit.loadNearbyPlaces();
                  }
                  if (state is SplashCompleteSearch) {
                    const goToLogin = true;

                    if (goToLogin) {
                      _scheduleNavigateLogin();
                    } else {
                      _scheduleNavigateMain(context, themeManager);
                    }
                  }
                  return const SizedBox();
                }),
          ],
        ),
      ),
    );
  }

  void _scheduleNavigateLogin() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Modular.to.pushNamed('/auth');
    });
  }

  void _scheduleNavigateMain(BuildContext context, ThemeManager themeManager) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _navigateToMain(context, themeManager);
    });
  }

  void _navigateToMain(BuildContext context, ThemeManager themeManager) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavigation(themeManager: themeManager),
      ),
    );
  }
}
