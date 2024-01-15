import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/main_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(DarkMode());

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var currentTheme = ThemeMode.dark;
  var navigateToHome = true;
  var selectedBottomNavItem = 0;

  static const home = 0;
  static const events = 1;
  static const favorites = 2;
  static const settings = 3;

  void getTheme() async {
    final SharedPreferences prefs = await _prefs;
    final darkTheme = prefs.getBool('darkTheme') ?? true;

    if (darkTheme) {
      currentTheme = ThemeMode.dark;
      emit(DarkMode());
    } else {
      currentTheme = ThemeMode.light;
      emit(LightMode());
    }
  }

  void toggleTheme(bool isDark) async {
    final SharedPreferences prefs = await _prefs;

    navigateToHome = true;
    selectedBottomNavItem = settings;

    if (isDark) {
      prefs.setBool('darkTheme', true);
      currentTheme = ThemeMode.dark;
      emit(DarkMode());
    } else {
      prefs.setBool('darkTheme', false);
      currentTheme = ThemeMode.light;
      emit(LightMode());
    }
  }
}
