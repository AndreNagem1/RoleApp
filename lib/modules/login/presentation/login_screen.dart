import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/modules/login/presentation/signup_screen.dart';
import 'package:rolesp/widgets/round_buttton.dart';

import '../../../bottomNavigator/BottomNavigation.dart';
import '../../../theme/themeManager.dart';
import '../../../widgets/input_text.dart';

class LoginScreen extends StatefulWidget {
  final ThemeManager themeManager;

  const LoginScreen({super.key, required this.themeManager});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Text(
              'Entrar',
              style: GoogleFonts.righteous(
                textStyle: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
              child: InputText(
                hint: 'Email',
                backgroundColor: Theme.of(context).colorScheme.onSurface,
                onTextChange: (input) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
              child: InputText(
                hint: 'Senha',
                backgroundColor: Theme.of(context).colorScheme.onSurface,
                onTextChange: (input) {},
              ),
            ),
            const Spacer(),
            RoundButton(
              text: 'Entrar',
              height: 50,
              width: double.infinity,
              backGroundColor: Theme.of(context).colorScheme.onSurface,
              borderColor: Colors.transparent,
              font: GoogleFonts.righteous(
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              onPress: () {},
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                RoundButton(
                  text: 'Criar conta',
                  height: 50,
                  width: screenWidth * 0.7,
                  backGroundColor: Colors.transparent,
                  borderColor: Theme.of(context).colorScheme.onSurface,
                  font: GoogleFonts.righteous(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onPress: () {
                    _navigateToSignUp();
                  },
                ),
                const SizedBox(width: 5),
                RoundButton(
                  text: 'Pular',
                  height: 50,
                  width: screenWidth * 0.2,
                  backGroundColor: Colors.transparent,
                  borderColor: Theme.of(context).colorScheme.onSurface,
                  font: GoogleFonts.righteous(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onPress: () {
                    _navigateToMain();
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _navigateToSignUp() {
    Modular.to.pushNamed('/auth/signUp');
  }

  void _navigateToMain() {
    Modular.to.pushNamed('/home');
  }
}
