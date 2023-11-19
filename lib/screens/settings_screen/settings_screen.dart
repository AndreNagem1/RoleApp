import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolesp/screens/settings_screen/settings_cubit.dart';
import 'package:rolesp/screens/settings_screen/settings_screen_state.dart';
import 'package:rolesp/theme/roleTheme.dart';
import 'package:rolesp/widgets/home_banner.dart';

import '../../theme/themeManager.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeManager themeManager;

  SettingsScreen({
    Key? key,
    required this.themeManager,
  }) : super(key: key);

  final bloc = SettingsCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<SettingsCubit, SettingsScreenState>(
        bloc: bloc,
        builder: (context, state) {
          var showConfig = false;
          var showAboutUs = false;
          var showHelp = false;

          if (state is OptionSelected) {
            if (state.selectedOption == SelectedOption.configurations) {
              showConfig = true;
            }
            if (state.selectedOption == SelectedOption.aboutUs) {
              showAboutUs = true;
            }
            if (state.selectedOption == SelectedOption.help) {
              showHelp = true;
            }
            if (state.selectedOption == SelectedOption.none) {
              showConfig = false;
              showAboutUs = false;
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
                    profileOption('Configurações', context, showConfig, () {
                      bloc.selectOption(SelectedOption.configurations);
                    }),
                    if (showConfig) configurations(context, themeManager),
                    const SizedBox(height: 15),
                    profileOption('Sobre nós', context, showAboutUs, () {
                      bloc.selectOption(SelectedOption.aboutUs);
                    }),
                    if (showAboutUs) aboutUsContent(context, themeManager),
                    const SizedBox(height: 15),
                    profileOption('Ajuda', context, showHelp, () {
                      bloc.selectOption(SelectedOption.help);
                    }),
                    if (showHelp) helpContent(context, themeManager),
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

Widget profileOption(
    String title, BuildContext context, bool isSelected, VoidCallback onTap) {
  var icon = Icons.chevron_right_outlined;

  if (isSelected) {
    icon = Icons.arrow_drop_down;
  }

  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Row(children: [
          Text(title),
          const Spacer(),
          Icon(
            icon,
            size: 33,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ]),
        const SizedBox(height: 10),
        Container(
          height: 0.5,
          width: double.infinity,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ],
    ),
  );
}

Widget configurations(BuildContext context, ThemeManager themeManager) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Switch(
          activeColor: Theme.of(context).colorScheme.onSurface,
          inactiveThumbColor: Theme.of(context).colorScheme.onSurface,
          value: themeManager.themeMode == ThemeMode.light,
          onChanged: (newValue) {
            themeManager.toggleTheme(newValue);
          })
    ],
  );
}

Widget aboutUsContent(BuildContext context, ThemeManager themeManager) {
  return const Column(
    children: [
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
                'Quem nós somos ahsudhsau ashdaushxl,zncaos saoidh alxzkjdlhxc aljsda oaisjd aoauhsdas ohsa .'),
          ),
        ],
      ),
    ],
  );
}

Widget helpContent(BuildContext context, ThemeManager themeManager) {
  return const Column(
    children: [
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
                'Para falar conosco aisuhsaio coaishd oaisd aoiad oiasd oaishdoias oaihdoias oasihdaois oaushd a.'),
          ),
        ],
      ),
    ],
  );
}
