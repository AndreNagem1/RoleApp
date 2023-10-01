import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/screens/map_screen/ui/BottomNavigation.dart';
import 'package:rolesp/screens/splash_screen/domain/cubit/SplashCubit.dart';
import 'package:rolesp/screens/splash_screen/domain/states/SplashScreenState.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = SplashCubit(SplashScreenInitialtate());

    return Scaffold(
      backgroundColor: ColorsRoleSp.background,
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
            const CircularProgressIndicator(
              color: ColorsRoleSp.whiteLetter,
            ),
            BlocBuilder<SplashCubit, SplashScreenState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is SplashScreenInitialtate) {
                    cubit.loadNearbyPlaces();
                  }
                  if (state is SplashCompleteSearch) {
                    _scheduleNavigateMain(context);
                  }
                  return const SizedBox();
                }),
          ],
        ),
      ),
    );
  }

  void _scheduleNavigateMain(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _navigateToMain(context);
    });
  }

  void _navigateToMain(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigation(),
      ),
    );
  }
}
