import 'package:flutter_modular/flutter_modular.dart';
import 'package:rolesp/modules/login/presentation/login_screen.dart';
import 'package:rolesp/modules/login/presentation/signup_screen.dart';
import 'package:rolesp/theme/themeManager.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<ThemeManager>(ThemeManager.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => LoginScreen(
        themeManager: Modular.get<ThemeManager>(),
      ),
    );
    r.child(
      '/signUp',
      child: (context) => SignUpScreen(
        themeManager: Modular.get<ThemeManager>(),
      ),
    );
  }
}
