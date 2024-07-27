import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/Resources/ColorsRoleSp.dart';
import 'package:rolesp/screens/settings_screen/settings_cubit.dart';
import 'package:rolesp/screens/settings_screen/settings_screen_state.dart';
import 'package:rolesp/theme/roleTheme.dart';
import 'package:rolesp/widgets/home_banner.dart';

import '../../main_cubit.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final bloc = SettingsCubit();
  final mainCubit = Modular.get<MainCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<SettingsCubit, SettingsScreenState>(
        bloc: bloc,
        builder: (context, state) {
          var showConfig = false;
          var showHelp = false;

          if (state is OptionSelected) {
            if (state.selectedOption == SelectedOption.configurations) {
              showConfig = true;
            }
            if (state.selectedOption == SelectedOption.help) {
              showHelp = true;
            }
            if (state.selectedOption == SelectedOption.none) {
              showConfig = false;
              showHelp = false;
            }
          }

          return ListView(
            children: [
              HomeBanner(
                  isLight: Theme.of(context).colorScheme == lightColorScheme),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        profileOption('Configurações', context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Switch(
                              activeColor:
                                  Theme.of(context).colorScheme.onSurface,
                              inactiveThumbColor:
                                  Theme.of(context).colorScheme.onSurface,
                              value: mainCubit.currentTheme == ThemeMode.dark,
                              onChanged: (newValue) {
                                mainCubit.toggleTheme(newValue);
                              },
                            ),
                            const SizedBox(width: 5),
                            if (mainCubit.currentTheme == ThemeMode.dark)
                              Text(
                                'Dark mode',
                                style: GoogleFonts.righteous(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            if (mainCubit.currentTheme != ThemeMode.dark)
                              Text(
                                'Light mode',
                                style: GoogleFonts.righteous(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        profileOption('Info', context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'contato@rolesp.com.br',
                                style: GoogleFonts.righteous(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

Widget profileOption(String title, BuildContext context) {
  return Container(
    color: Colors.transparent,
    child: Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 0.5,
          width: double.infinity,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}
