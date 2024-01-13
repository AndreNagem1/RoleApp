import 'package:flutter_modular/flutter_modular.dart';
import 'package:rolesp/modules/login/presentation/login_screen.dart';
import 'package:rolesp/modules/login/presentation/signup_screen.dart';

class AuthModule extends Module {


  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const LoginScreen(),
    );
    r.child(
      '/signUp',
      child: (context) => const SignUpScreen(),
    );
  }
}
