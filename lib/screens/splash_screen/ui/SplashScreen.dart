import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rolesp/main_cubit.dart';
import 'package:rolesp/screens/splash_screen/domain/cubit/SplashCubit.dart';
import 'package:rolesp/screens/splash_screen/domain/states/SplashScreenState.dart';

import '../../events_screen/ui/events_background.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = SplashCubit(SplashScreenInitialtate());
    final mainCubit = Modular.get<MainCubit>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CustomPaint(
          size: const Size(double.infinity, double.infinity),
          painter: VectorBackgroundPainter(context),
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
                      if (mainCubit.navigateToHome) {
                        _navigateToMain(mainCubit.selectedBottomNavItem);
                      } else {
                        _scheduleNavigateLogin();
                      }
                    }
                    return const SizedBox();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void _scheduleNavigateLogin() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Modular.to.pushReplacementNamed('/auth');
    });
  }

  void _navigateToMain(int selectedItem) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Modular.to.pushReplacementNamed('/home/?selectedItem=$selectedItem');
    });
  }
}
