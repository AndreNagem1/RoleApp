import 'package:flutter_modular/flutter_modular.dart';
import 'package:rolesp/main_cubit.dart';
import 'package:rolesp/screens/settings_screen/settings_screen.dart';
import 'package:rolesp/screens/splash_screen/ui/SplashScreen.dart';
import 'package:rolesp/services/firebase_messaging_service.dart';
import 'package:rolesp/services/notification_service.dart';

import 'home_module.dart';
import 'modules/login/auth_module.dart';

class AppModule extends Module {

  @override
  void binds(i) {
    i.addSingleton<MainCubit>(MainCubit.new);
    i.addSingleton<NotificationService>(NotificationService.new);
    i.addSingleton<FirebaseMessagingService>(FirebaseMessagingService.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const SplashScreen(),
    );
    r.module('/auth', module: AuthModule());
    r.module('/home', module: HomeModule());
    r.child(
      '/settings',
      child: (context) => SettingsScreen(),
    );
  }
}
