import 'package:flutter_modular/flutter_modular.dart';
import 'package:rolesp/screens/splash_screen/ui/SplashScreen.dart';
import 'package:rolesp/theme/themeManager.dart';

import 'modules/login/auth_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<ThemeManager>(ThemeManager.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => SplashScreen(
        themeManager: Modular.get<ThemeManager>(),
      ),
    );
    r.module('/auth', module: AuthModule());
  }
}
