import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/widgets/round_buttton.dart';

import '../../../theme/themeManager.dart';
import '../../../widgets/input_text.dart';

class SignUpScreen extends StatelessWidget {
  final ThemeManager themeManager;

  const SignUpScreen({super.key, required this.themeManager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Text(
              'Criar conta',
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
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
              child: InputText(
                hint: 'Confirmação de senha',
                backgroundColor: Theme.of(context).colorScheme.onSurface,
                onTextChange: (input) {},
              ),
            ),
            const Spacer(),
            RoundButton(
              text: 'Criar conta',
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
            RoundButton(
              text: 'Voltar',
              height: 50,
              width: double.infinity,
              backGroundColor: Colors.transparent,
              borderColor: Colors.transparent,
              font: GoogleFonts.righteous(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              onPress: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
