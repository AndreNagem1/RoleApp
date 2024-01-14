import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolesp/main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(DarkMode());

  var currentTheme = ThemeMode.dark;
  var navigateToHome = true;
  var selectedBottomNavItem = 0;

  static const home = 0;
  static const events = 1;
  static const favorites = 2;
  static const settings = 3;

  void toggleTheme(bool isDark) {
    navigateToHome = true;
    selectedBottomNavItem = settings;

    if (isDark) {
      currentTheme = ThemeMode.dark;
      emit(DarkMode());
    } else {
      currentTheme = ThemeMode.light;
      emit(LightMode());
    }
  }
}
